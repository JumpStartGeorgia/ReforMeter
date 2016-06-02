# Non-resource pages
class RootController < ApplicationController
  def index
    @home_page_about = PageContent.find_by(name: 'home_page_about')

    @quarter = Quarter.latest
    @reforms = Reform.active.sorted.highlight

    # get the survey data for charting
    expert_survey_data = Quarter.expert_survey_data_for_charting(overall_score_only: true)

    reform_survey_data = []
    @reforms.each do |reform|
      reform_survey_data << Quarter.reform_survey_data_for_charting(reform.id, overall_score_only: true)
    end

    # get external indicators for home page
    @external_indicators = ExternalIndicator.published.for_home_page.sorted
    if @external_indicators.present?
      ext_ind_chart_data = []
      @external_indicators.each do |ei|
        ext_ind_chart_data << ei.format_for_charting
      end
    end

  end

  def about
    @about_text = PageContent.find_by(name: 'about_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')
    @methodology_government = PageContent.find_by(name: 'methodology_government')
    @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
  end

  def contact
  end

  def download_data_and_reports
    @download_text = PageContent.find_by(name: 'download_text')
    @download_expert_text = PageContent.find_by(name: 'download_expert_text')
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
        when 'expert'
          data = Quarter.to_csv('expert')
          filename = 'ReforMeter_Expert_Data'
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

  def reforms
    @reform_text = PageContent.find_by(name: 'reform_text')
    @quarters = Quarter.published.recent
    @reforms = Reform.active.sorted.with_color
    @reform_surveys = ReformSurvey.in_quarters(@quarters.map{|x| x.id}) if @quarters.present?

    reform_survey_data = []
    @reforms.each do |reform|
      reform_survey_data << Quarter.reform_survey_data_for_charting(reform.id, overall_score_only: true)
    end
  end

  def reform_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:quarter_id])
      @reform = Reform.active.with_color.friendly.find(params[:reform_id])
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
      logger.debug "======= reform id #{@reform.id}; quarter id = #{@quarter.id}, news length = #{@news.length}"

      gon.change_icons = view_context.change_icons

      gon.charts = [
        Quarter.reform_survey_data_for_charting(@reform.id, type: 'government', id: 'reform-government-history'),
        {
          id: 'reform-government-overall',
          title: I18n.t('shared.categories.overall'),
          score: @reform_survey.government_overall_score.to_f,
          change: @reform_survey.government_overall_change
        }, {
          id: 'reform-government-institutional-setup',
          title: I18n.t('shared.categories.initial_setup'),
          score: @reform_survey.government_category1_score.to_f,
          change: @reform_survey.government_category1_change
        }, {
          id: 'reform-government-capacity-building',
          title: I18n.t('shared.categories.capacity_building'),
          score: @reform_survey.government_category2_score.to_f,
          change: @reform_survey.government_category2_change
        }, {
          id: 'reform-government-infrastructure-budgeting',
          title: I18n.t('shared.categories.infastructure_budgeting'),
          score: @reform_survey.government_category3_score.to_f,
          change: @reform_survey.government_category3_change
        }, {
          id: 'reform-government-legislation-regulations',
          title: I18n.t('shared.categories.legislation_regulation'),
          score: @reform_survey.government_category4_score.to_f,
          change: @reform_survey.government_category4_change
        },
        Quarter.reform_survey_data_for_charting(@reform.id, type: 'stakeholder', id: 'reform-stakeholder-history'),
        {
          id: 'reform-stakeholder-overall',
          title: t('shared.categories.overall'),
          score: @reform_survey.stakeholder_overall_score.to_f,
          icon: view_context.generate_change_icon(@reform_survey.stakeholder_overall_change)
        }, {
          id: 'reform-stakeholder-performance',
          title: t('shared.categories.performance'),
          score: @reform_survey.stakeholder_category1_score.to_f,
          icon: view_context.generate_change_icon(@reform_survey.stakeholder_category1_change)
        }, {
          id: 'reform-stakeholder-goals',
          title: t('shared.categories.goals'),
          score: @reform_survey.stakeholder_category2_score.to_f,
          icon: view_context.generate_change_icon(@reform_survey.stakeholder_category2_change)
        }, {
          id: 'reform-stakeholder-progress',
          title: t('shared.categories.progress'),
          score: @reform_survey.stakeholder_category3_score.to_f,
          icon: view_context.generate_change_icon(@reform_survey.stakeholder_category3_change)
        }
      ]

      # get external indicators for this reform
      @external_indicators = @reform.external_indicators.published.sorted
      if @external_indicators.present?
        ext_ind_chart_data = []
        @external_indicators.each do |ei|
          ext_ind_chart_data << ei.format_for_charting
        end
      end

    rescue ActiveRecord::RecordNotFound  => e
      redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

  def experts
    @expert_text = PageContent.find_by(name: 'expert_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')

    @quarters = Quarter.published.recent.with_expert_survey

    gon.change_icons = view_context.change_icons

    gon.charts = [
      Quarter.expert_survey_data_for_charting(overall_score_only: true)
    ]

    @quarters.each do |quarter|
      gon.charts << {
        id: quarter.slug,
        chartType: 'small-meter-gauge',
        title: nil,
        score: quarter.expert_survey.overall_score.to_f,
        icon: view_context.generate_change_icon(quarter.expert_survey.overall_change)
      }
    end

  end

  def expert_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:id])

      if @quarter.nil?
        redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
      end

      @active_quarters = Quarter.active_quarters_array
      @methodology_expert = PageContent.find_by(name: 'methodology_expert')
      @news = News.by_expert_quarter(@quarter.id)

      gon.change_icons = view_context.change_icons



      gon.charts = [
        Quarter.expert_survey_data_for_charting, {
          chartType: 'big-meter-gauge',
          id: 'overall',
          title: I18n.t('shared.categories.overall'),
          score: @quarter.expert_survey.overall_score.to_f,
          icon: view_context.generate_change_icon(@quarter.expert_survey.overall_change)
        }, {
          chartType: 'small-meter-gauge',
          id: 'performance',
          title: I18n.t('shared.categories.performance'),
          score: @quarter.expert_survey.category1_score.to_f,
          icon: view_context.generate_change_icon(@quarter.expert_survey.category1_change)
        }, {
          chartType: 'small-meter-gauge',
          id: 'goals',
          title: I18n.t('shared.categories.goals'),
          score: @quarter.expert_survey.category2_score.to_f,
          icon: view_context.generate_change_icon(@quarter.expert_survey.category2_change)
        }, {
          chartType: 'small-meter-gauge',
          id: 'progress',
          title: I18n.t('shared.categories.progress'),
          score: @quarter.expert_survey.category3_score.to_f,
          icon: view_context.generate_change_icon(@quarter.expert_survey.category3_change)
        }
      ]

    rescue ActiveRecord::RecordNotFound => e
      redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

end
