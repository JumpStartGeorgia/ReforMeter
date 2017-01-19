# Non-resource pages
class RootController < ApplicationController
  def index
    @quarter = Quarter.published.with_expert_survey.latest
    @external_indicators = ExternalIndicator.published.for_home_page
    @reforms = Reform.with_reform_survey(@quarter.id).in_quarter(@quarter.id).active.highlight.sorted if @quarter

    gon.change_icons = view_context.change_icons

    gon.charts = []

    if @quarter.present?
      charts = [
        # note: see below for chart being used for shareable image
        Chart.new(
          {
            id: 'reform-current-overall',
            title: nil,
            responsiveTo: '.js-homepage-primary-gauge-container',
            score: @quarter.expert_survey.overall_score.to_f,
            change: @quarter.expert_survey.overall_change
          }
        )
      ]

      # The homepage primary gauge, when made shareable, creates an image
      # with a size depending on the width of the screen the first
      # person uses to create it (the actual highcharts config is responsive
      # to the container width). However, the homepage share image should
      # always be the biggest width that it can be. So, we create a copy
      # of the primary gauge and only load it IF it's png image does not
      # yet exist. If the png image does not exist, and this second primary
      # gauge chart is created, then the div container has display: none; to
      # hide it.
      primary_gauge_for_image = Chart.new(
        {
          id: 'reform-current-overall-for-share',
          title: I18n.t('root.index.heading'),
          subtitle: I18n.t('root.index.subheading'),
          size: 300,
          score: @quarter.expert_survey.overall_score.to_f,
          change: @quarter.expert_survey.overall_change
        },
        request.path
      )

      unless (primary_gauge_for_image.png_image_exists?)
        charts << primary_gauge_for_image
      end

      gon.charts = charts.map(&:to_hash)

      @share_image_paths = [primary_gauge_for_image.png_image_path]

    end

    if @reforms.present?
      @reforms.each do |reform|
        survey = reform.reform_surveys[0]

        next unless survey

        gon.charts << {
          id: "reform-government-#{@quarter.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.government_overall_score.to_f,
          change: survey.government_overall_change
        }

        gon.charts << {
          id: "reform-stakeholder-#{@quarter.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.stakeholder_overall_score.to_f,
          change: survey.stakeholder_overall_change
        }
      end
    end

    if @quarter.present? && @external_indicators.present?
      gon.charts += @external_indicators.each_with_index.map do |external_indicator, index|
        external_indicator.gauge_chart_data(index, '.js-external-indicator-gauges-container')
      end
    end
  end

  def about
    @about_text = PageContent.find_by(name: 'about_text')
    @methodology_general = PageContent.find_by(name: 'methodology_general')
    @steering_committee = Expert.steering_committee_members.active.sorted
    @executive_team = Expert.executive_team_members.active.sorted
  end

  def download_data_and_reports
    @download_text = PageContent.find_by(name: 'download_text')
    @download_reform_text = PageContent.find_by(name: 'download_reform_text')
    @download_external_indicator_text = PageContent.find_by(name: 'download_external_indicator_text')
    @download_report_text = PageContent.find_by(name: 'download_report_text')

    @reforms = Reform.active.sorted
    @quarters = Quarter.published.recent
    @external_indicators = ExternalIndicator.published.sorted

    # if there is a download request, process it
    if request.post? && params[:type].present?
      data,filename = nil
      is_csv = false
      case params[:type]
        when 'review_board'
          data = Quarter.to_csv('expert')
          filename = 'ReforMeter_Review_Board_Data'
          is_csv = true
        when 'reform'
          reform = Reform.friendly.find(params[:reform_id])
          if reform
            data = Quarter.to_csv('reform', reform.id)
            filename = "ReforMeter_#{reform.name}_Reform_Data"
            is_csv = true
          else

          end
        when 'external_indicator'
          ext_ind = ExternalIndicator.find_by(id: params[:external_indicator_id])
          if ext_ind
            data = ExternalIndicator.to_csv(ext_ind.id)
            filename = "ReforMeter_#{ext_ind.title}_External_Indicator_Data"
            is_csv = true
          end
        when 'report'
          # just need the url to the file
          quarter = @quarters.select{|x| x.slug == params[:quarter]}.first
          data = quarter.report.path if quarter
      end

      # send the file
      if data
        if is_csv
          send_data data, filename: clean_filename("#{filename}-#{I18n.l(Time.now, :format => :file)}") + ".csv"
        else
          ext = File.extname(data)
          filename = File.basename(data, ext)
          send_file data, filename: clean_filename("#{filename}-#{I18n.l(Time.now, :format => :file)}") + ext
        end
      end
    end
  end

  def economic_effects
    @most_recent_quarter = Quarter.published.latest
    @external_indicators = ExternalIndicator.published.sorted_for_list_page

    gon.change_icons = view_context.change_icons

    charts = @external_indicators.map do |external_indicator|
      Chart.new(
        external_indicator.format_for_charting,
        request.path
      )
    end

    @share_image_paths = charts.select(&:png_image_exists?).map(&:png_image_path)

    chart_hashes = charts.map do |chart|
      chart_config = chart.to_hash
      chart_config[:displayTitle] = false
      chart_config[:displaySubtitle] = false
      chart_config
    end

    gon.charts = []
    gon.charts += chart_hashes
  end

  def reforms
    @reform_text = PageContent.find_by(name: 'reform_text')
    @methodology_government = PageContent.find_by(name: 'methodology_government')
    @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
    @quarters = Quarter.published.recent
    @reforms = Reform.with_survey_data.active.with_color.sorted
    @reform_surveys = ReformSurvey.in_quarters(@quarters.map{|x| x.id}) if @quarters.present?

    gon.chart_download = highchart_export_config
    gon.change_icons = view_context.change_icons

    charts = [
      Chart.new(
        Quarter.all_reform_survey_data_for_charting(id: 'reforms-history-series', quarter_ids: @quarters.map{|x| x.id}),
        request.path
      )
    ]

    @share_image_paths = charts.select(&:png_image_exists?).map(&:png_image_path)
    gon.charts = charts.map(&:to_hash)

    @quarters.each do |quarter|
      surveys = @reform_surveys.select{|x| x.quarter_id == quarter.id}

      surveys.each do |survey|
        reform = @reforms.select{|x| x.id == survey.reform_id}.first

        next unless reform

        gon.charts << {
          id: "reform-government-#{quarter.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.government_overall_score.to_f,
          change: survey.government_overall_change
        }

        gon.charts << {
          id: "reform-stakeholder-#{quarter.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.stakeholder_overall_score.to_f,
          change: survey.stakeholder_overall_change
        }
      end
    end
  end

  def reform_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:quarter_id])
      @reform = Reform.with_survey_data.active.with_color.friendly.find(params[:reform_id])
      @reform_survey = ReformSurvey.for_reform(@reform.id).in_quarter(@quarter.id).first if @quarter && @reform

      if @reform.nil? || @quarter.nil? || @reform_survey.nil?
        redirect_to reforms_path,
                alert: t('shared.msgs.does_not_exist')
      end

      @active_reforms = Reform.active_reforms_array
      @active_quarters = Quarter.active_quarters_array
      @methodology_government = PageContent.find_by(name: 'methodology_government')
      @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
      @news = News.by_reform_quarter(@quarter.id, @reform.id)
      @stakeholders = Expert.stakeholders.by_reform(@reform.id).active.sorted

      gon.linked_reforms_quarters = Quarter.linked_reforms
      gon.chart_download = highchart_export_config
      gon.change_icons = view_context.change_icons

      @quarter_ids = Quarter.with_reform(@reform.id).published.recent.pluck(:id)

      government_time_series = Chart.new(
        Quarter.reform_survey_data_for_charting(
          @reform.id,
          type: 'government',
          id: 'reform-government-history',
          quarter_ids: @quarter_ids
        ),
        request.path
      )

      stakeholder_time_series = Chart.new(
        Quarter.reform_survey_data_for_charting(
          @reform.id,
          type: 'stakeholder',
          id: 'reform-stakeholder-history',
          quarter_ids: @quarter_ids
        ),
        request.path
      )

      charts = [
        government_time_series,
        stakeholder_time_series
      ]

      gon.charts = charts.map(&:to_hash)

      government_color = government_time_series.to_hash[:color]

      government_overall_gauge = Chart.new({
        id: 'reform-government-overall',
        color: government_color,
        title: I18n.t('shared.categories.overall'),
        score: @reform_survey.government_overall_score.to_f,
        change: @reform_survey.government_overall_change
      })

      government_institutional_gauge = Chart.new({
        id: 'reform-government-institutional-setup',
        title: I18n.t('shared.categories.initial_setup'),
        score: @reform_survey.government_category1_score.to_f,
        change: @reform_survey.government_category1_change
      })

      government_capacity_gauge = Chart.new({
        id: 'reform-government-capacity-building',
        title: I18n.t('shared.categories.capacity_building'),
        score: @reform_survey.government_category2_score.to_f,
        change: @reform_survey.government_category2_change
      })

      government_infrastructure_gauge = Chart.new({
        id: 'reform-government-infrastructure-budgeting',
        title: I18n.t('shared.categories.infastructure_budgeting'),
        score: @reform_survey.government_category3_score.to_f,
        change: @reform_survey.government_category3_change
      })

      government_legislation_gauge = Chart.new({
        id: 'reform-government-legislation-regulations',
        title: I18n.t('shared.categories.legislation_regulation'),
        score: @reform_survey.government_category4_score.to_f,
        change: @reform_survey.government_category4_change
      })

      stakeholder_overall_gauge = Chart.new({
        id: 'reform-stakeholder-overall',
        color: government_color,
        title: t('shared.categories.overall'),
        score: @reform_survey.stakeholder_overall_score.to_f,
        change: @reform_survey.stakeholder_overall_change
      })

      stakeholder_performance_gauge = Chart.new({
        id: 'reform-stakeholder-performance',
        color: government_color,
        title: t('shared.categories.performance'),
        score: @reform_survey.stakeholder_category1_score.to_f,
        change: @reform_survey.stakeholder_category1_change
      })

      # stakeholder_goals_gauge = Chart.new({
      #   id: 'reform-stakeholder-goals',
      #   color: government_color,
      #   title: t('shared.categories.goals'),
      #   score: @reform_survey.stakeholder_category2_score.to_f,
      #   change: @reform_survey.stakeholder_category2_change
      # })

      stakeholder_progress_gauge = Chart.new({
        id: 'reform-stakeholder-progress',
        color: government_color,
        title: t('shared.categories.progress'),
        score: @reform_survey.stakeholder_category2_score.to_f,
        change: @reform_survey.stakeholder_category2_change
      })

      stakeholder_goals_gauge = Chart.new({
        id: 'reform-stakeholder-outcome',
        color: government_color,
        title: t('shared.categories.outcome'),
        score: @reform_survey.stakeholder_category3_score.to_f,
        change: @reform_survey.stakeholder_category3_change
      })

      if @reform_survey.present?
        [
          government_overall_gauge.to_hash,
          government_institutional_gauge.to_hash,
          government_capacity_gauge.to_hash,
          government_infrastructure_gauge.to_hash,
          government_legislation_gauge.to_hash,
          stakeholder_overall_gauge.to_hash,
          stakeholder_performance_gauge.to_hash,
          stakeholder_goals_gauge.to_hash,
          stakeholder_progress_gauge.to_hash
        ].each { |chart| gon.charts << chart }
      end

      reform_government_gauge_group = ChartGroup.new(
        [
          government_overall_gauge,
          government_institutional_gauge,
          government_capacity_gauge,
          government_infrastructure_gauge,
          government_legislation_gauge
        ],
        id: 'reform-government-gauge-group',
        title: I18n.t(
          'root.reform_show.gauge_group.title',
          name: @reform.name
        ),
        subtitle: I18n.t(
          'root.reform_show.gauge_group.government.subtitle',
          quarter: @quarter.time_period
        ),
        page_path: request.path
      )

      reform_stakeholder_gauge_group = ChartGroup.new(
        [
          stakeholder_overall_gauge,
          stakeholder_performance_gauge,
          stakeholder_goals_gauge,
          stakeholder_progress_gauge
        ],
        id: 'reform-stakeholder-gauge-group',
        title: I18n.t(
          'root.reform_show.gauge_group.title',
          name: @reform.name
        ),
        subtitle: I18n.t(
          'root.reform_show.gauge_group.stakeholder.subtitle',
          quarter: @quarter.time_period
        ),
        page_path: request.path
      )

      gon.chartGroups = [
        reform_government_gauge_group,
        reform_stakeholder_gauge_group
      ]

      @share_image_paths = [
        government_time_series,
        stakeholder_time_series,
        reform_government_gauge_group,
        reform_stakeholder_gauge_group
      ].select(&:png_image_exists?).map(&:png_image_path)

      @external_indicators = @reform.external_indicators.published.sorted

      gon.charts += @external_indicators.map(&:format_for_charting)

    rescue ActiveRecord::RecordNotFound  => e
      redirect_to reforms_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

  def reform_verdict

  end

  def reform_verdict_show

  end

  # def review_board
  #   @expert_text = PageContent.find_by(name: 'review_board_text')
  #   @methodology_review_board = PageContent.find_by(name: 'methodology_review_board')

  #   @quarters = Quarter.published.recent.with_expert_survey
  #   @experts = Expert.active.sorted

  #   gon.chart_download = highchart_export_config
  #   gon.change_icons = view_context.change_icons

  #   charts = [
  #     Chart.new(
  #       Quarter.expert_survey_data_for_charting(
  #         overall_score_only: true,
  #         id: 'expert-history'
  #       ),
  #       request.path
  #     )
  #   ]

  #   gon.charts = charts.map(&:to_hash)

  #   @share_image_paths = charts.select(&:png_image_exists?).map(&:png_image_path)

  #   @quarters.each do |quarter|
  #     gon.charts << {
  #       id: quarter.slug,
  #       title: nil,
  #       score: quarter.expert_survey.overall_score.to_f,
  #       change: quarter.expert_survey.overall_change
  #     }
  #   end

  # end

  # def review_board_show
  #   begin
  #     @quarter = Quarter.published.with_expert_survey.friendly.find(params[:id])

  #     if @quarter.nil?
  #       redirect_to review_board_path,
  #               alert: t('shared.msgs.does_not_exist')
  #     end

  #     @active_quarters = Quarter.active_quarters_array
  #     @methodology_review_board = PageContent.find_by(name: 'methodology_review_board')
  #     @news = News.by_expert_quarter(@quarter.id)

  #     gon.chart_download = highchart_export_config
  #     gon.change_icons = view_context.change_icons

  #     expert_history_chart = Chart.new(
  #       Quarter.expert_survey_data_for_charting(id: 'expert-history'),
  #       request.path
  #     )

  #     expert_overall_gauge = Chart.new({
  #       id: 'overall',
  #       title: I18n.t('shared.categories.overall'),
  #       score: @quarter.expert_survey.overall_score.to_f,
  #       change: @quarter.expert_survey.overall_change
  #     })

  #     expert_performance_gauge = Chart.new({
  #       id: 'performance',
  #       title: I18n.t('shared.categories.performance'),
  #       score: @quarter.expert_survey.category1_score.to_f,
  #       change: @quarter.expert_survey.category1_change
  #     })

  #     expert_goals_gauge = Chart.new({
  #       id: 'goals',
  #       title: I18n.t('shared.categories.goals'),
  #       score: @quarter.expert_survey.category2_score.to_f,
  #       change: @quarter.expert_survey.category2_change
  #     })

  #     expert_progress_gauge = Chart.new({
  #       id: 'progress',
  #       title: I18n.t('shared.categories.progress'),
  #       score: @quarter.expert_survey.category3_score.to_f,
  #       change: @quarter.expert_survey.category3_change
  #     })

  #     expert_gauge_group = ChartGroup.new(
  #       [
  #         expert_overall_gauge,
  #         expert_performance_gauge,
  #         expert_goals_gauge,
  #         expert_progress_gauge
  #       ],
  #       id: 'expert-gauge-group',
  #       title: I18n.t(
  #         'root.review_board_show.gauge_group.title',
  #         quarter: @quarter.time_period),
  #       page_path: request.path
  #     )

  #     gon.charts = [
  #       expert_history_chart.to_hash,
  #       expert_overall_gauge.to_hash,
  #       expert_performance_gauge.to_hash,
  #       expert_goals_gauge.to_hash,
  #       expert_progress_gauge.to_hash
  #     ]

  #     gon.chartGroups = [
  #       expert_gauge_group.to_hash
  #     ]

  #     @share_image_paths = [
  #       expert_history_chart,
  #       expert_gauge_group
  #     ].select(&:png_image_exists?).map(&:png_image_path)

  #   rescue ActiveRecord::RecordNotFound => e
  #     redirect_to review_board_path,
  #               alert: t('shared.msgs.does_not_exist')
  #   end
  # end

end
