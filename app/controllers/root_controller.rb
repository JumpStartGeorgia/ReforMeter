# Non-resource pages
class RootController < ApplicationController
  def index
    @verdict = Verdict.published.recent.first
    @external_indicators = ExternalIndicator.published.for_home_page
    @reforms = Reform.with_reform_survey(@verdict.id).in_verdict(@verdict.id).active.highlight.sorted if @verdict

    # @quarter = Quarter.published.with_expert_survey.latest

    gon.change_icons = view_context.change_icons

    gon.charts = []

    if @verdict.present?
      charts = [
        # note: see below for chart being used for shareable image
        Chart.new(
          {
            id: 'reform-current-overall',
            title: nil,
            responsiveTo: '.js-homepage-primary-gauge-container',
            score: @verdict.overall_score.to_f,
            change: @verdict.overall_change
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
          score: @verdict.overall_score.to_f,
          change: @verdict.overall_change
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
          id: "reform-government-#{@verdict.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.government_overall_score.to_f,
          change: survey.government_overall_change
        }

        gon.charts << {
          id: "reform-stakeholder-#{@verdict.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.stakeholder_overall_score.to_f,
          change: survey.stakeholder_overall_change
        }
      end
    end

    if @verdict.present? && @external_indicators.present?
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
    # @verdict = Verdict.published.recent
#    @quarters = Quarter.published.recent
    @external_indicators = ExternalIndicator.published.sorted
    @reports = Report.active.sorted

    # if there is a download request, process it
    if request.post? && params[:type].present?
      data,filename = nil
      is_csv = false
      case params[:type]
        # when 'review_board'
        #   data = Quarter.to_csv('expert')
        #   filename = 'ReforMeter_Review_Board_Data'
        #   is_csv = true
        when 'reform'
          reform = Reform.friendly.find(params[:reform_id])
          if reform
            data = Verdict.to_csv('reform', reform.id)
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
          report = @reports.select{|x| x.slug == params[:report]}.first
          data = report.report.path if report
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
    @most_recent_verdict = Verdict.published.recent.first
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
    # @quarters = Quarter.published.recent
    @verdicts = Verdict.published.recent
    @reforms = Reform.with_survey_data.active.with_color.sorted
    @reform_surveys = ReformSurvey.in_verdicts(@verdicts.map{|x| x.id}) if @verdicts.present?

    gon.chart_download = highchart_export_config
    gon.change_icons = view_context.change_icons

    @government_chart = Chart.new(
      Verdict.all_reform_survey_data_for_charting(
        id: 'reforms-government-history-series',
        type: 'government',
        verdict_ids: @verdicts.map{|x| x.id}
      ),
      request.path
    )

    @stakeholder_chart = Chart.new(
      Verdict.all_reform_survey_data_for_charting(
        id: 'reforms-stakeholder-history-series',
        type: 'stakeholder',
        verdict_ids: @verdicts.map{|x| x.id}
      ),
      request.path
    )

    charts = [
      @government_chart,
      @stakeholder_chart
    ]

    @share_image_paths = charts.select(&:png_image_exists?).map(&:png_image_path)
    gon.charts = charts.map(&:to_hash)

    @verdicts.each do |verdict|
      surveys = @reform_surveys.select{|x| x.verdict_id == verdict.id}

      surveys.each do |survey|
        reform = @reforms.select{|x| x.id == survey.reform_id}.first

        next unless reform

        gon.charts << {
          id: "reform-government-#{verdict.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.government_overall_score.to_f,
          change: survey.government_overall_change
        }

        gon.charts << {
          id: "reform-stakeholder-#{verdict.slug}-#{reform.slug}",
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
      @verdict = Verdict.published.friendly.find(params[:verdict_id])
      # @quarter = Quarter.published.with_expert_survey.friendly.find(params[:quarter_id])
      @reform = Reform.with_survey_data.active.with_color.friendly.find(params[:reform_id])
      @reform_survey = ReformSurvey.for_reform(@reform.id).in_verdict(@verdict.id).first if @verdict && @reform

      if @reform.nil? || @verdict.nil? || @reform_survey.nil?
        redirect_to reforms_path,
                alert: t('shared.msgs.does_not_exist')
      end

      # this is in app controler
      set_reform_show_variables

    rescue ActiveRecord::RecordNotFound  => e
      redirect_to reforms_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

  def reform_verdicts
    @verdict_text = PageContent.find_by(name: 'verdict')

    @verdicts = Verdict.published.recent

    gon.chart_download = highchart_export_config
    gon.change_icons = view_context.change_icons

    charts = [
      Chart.new(
        Verdict.verdict_data_for_charting(
          overall_score_only: true,
          id: 'verdict-history'
        ),
        request.path
      )
    ]

    gon.charts = charts.map(&:to_hash)

    @share_image_paths = charts.select(&:png_image_exists?).map(&:png_image_path)

    @verdicts.each do |verdict|
      gon.charts << {
        id: verdict.slug,
        title: nil,
        score: verdict.overall_score.to_f,
        change: verdict.overall_change
      }
    end
  end

  def reform_verdict_show
    begin
      @verdict = Verdict.published.friendly.find(params[:id])

      if @verdict.nil?
        redirect_to review_board_path,
                alert: t('shared.msgs.does_not_exist')
      end

      @active_verdicts = Verdict.active_verdicts_array
      @news = @verdict.news
      @reforms = Reform.with_survey_data.active.with_color.sorted
      @reform_surveys = ReformSurvey.in_verdict(@verdict.id)
      @methodology_government = PageContent.find_by(name: 'methodology_government')
      @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')

      gon.chart_download = highchart_export_config
      gon.change_icons = view_context.change_icons

      verdict_history_chart = Chart.new(
        Verdict.verdict_data_for_charting(id: 'verdict-history'),
        request.path
      )

      verdict_overall_gauge = Chart.new({
        id: 'overall',
        title: I18n.t('shared.categories.overall'),
        score: @verdict.overall_score.to_f,
        change: @verdict.overall_change
      })

      verdict_performance_gauge = Chart.new({
        id: 'performance',
        title: I18n.t('shared.categories.performance'),
        score: @verdict.category1_score.to_f,
        change: @verdict.category1_change
      })

      verdict_progress_gauge = Chart.new({
        id: 'progress',
        title: I18n.t('shared.categories.progress'),
        score: @verdict.category2_score.to_f,
        change: @verdict.category2_change
      })

      verdict_outcome_gauge = Chart.new({
        id: 'outcome',
        title: I18n.t('shared.categories.outcome'),
        score: @verdict.category3_score.to_f,
        change: @verdict.category3_change
      })

      verdict_gauge_group = ChartGroup.new(
        [
          verdict_overall_gauge,
          verdict_performance_gauge,
          verdict_progress_gauge,
          verdict_outcome_gauge
        ],
        id: 'verdict-gauge-group',
        title: I18n.t(
          'root.reform_verdict_show.gauge_group.title',
          time: @verdict.title),
        page_path: request.path
      )

      gon.charts = [
        verdict_history_chart.to_hash,
        verdict_overall_gauge.to_hash,
        verdict_performance_gauge.to_hash,
        verdict_progress_gauge.to_hash,
        verdict_outcome_gauge.to_hash
      ]

      gon.chartGroups = [
        verdict_gauge_group.to_hash
      ]

      @share_image_paths = [
        verdict_history_chart,
        verdict_gauge_group
      ].select(&:png_image_exists?).map(&:png_image_path)

      @reform_surveys.each do |survey|
        reform = @reforms.select{|x| x.id == survey.reform_id}.first

        next unless reform

        gon.charts << {
          id: "reform-government-#{@verdict.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.government_overall_score.to_f,
          change: survey.government_overall_change
        }

        gon.charts << {
          id: "reform-stakeholder-#{@verdict.slug}-#{reform.slug}",
          color: reform.color.to_hash,
          title: nil,
          score: survey.stakeholder_overall_score.to_f,
          change: survey.stakeholder_overall_change
        }
      end

    rescue ActiveRecord::RecordNotFound => e
      redirect_to reform_verdicts_path,
                alert: t('shared.msgs.does_not_exist')
    end
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
