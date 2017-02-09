# The central controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_global_vars

  ##############################################
  # Locales #

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    gon.locale = I18n.locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  ##############################################

  def set_global_vars
    # Used by share buttons in footer
    @addthis_id = ENV['ADDTHIS_ID']

    # indicate which year can be the first year for data
    @quarter_start_year = 2015
    
    gon.default_locale = I18n.default_locale.to_s

    gon.create_chart_share_image_url = charts_create_share_image_url

    gon.translations = {
      meter_gauge: {
        plot_band_label: {
          behind: I18n.t('shared.chart_rating_categories.reforms.behind'),
          on_track: I18n.t('shared.chart_rating_categories.reforms.on_track'),
          ahead: I18n.t('shared.chart_rating_categories.reforms.ahead')
        }
      },
      government: {
        rating: {
          middle: I18n.t('shared.chart_rating_categories.government.middle'),
          rising: I18n.t('shared.chart_rating_categories.government.rising')
        }
      }
    }
  end

  ##############################################
  # helpers

  def clean_filename(filename)
    filename.strip.to_url.gsub(' ', '_').gsub(/[\\ \/ \: \* \? \" \< \> \| \, \. ]/,'')
  end


  # get the quarter that this news items is for
  def get_quarter
    begin
      @quarter = Quarter.friendly.find(params[:quarter_id])

      if @quarter.nil?
        redirect_to admin_quarters_path,
                alert: t('shared.msgs.does_not_exist')
      end
    rescue ActiveRecord::RecordNotFound  => e
      redirect_to admin_quarters_path,
                alert: t('shared.msgs.does_not_exist')
    end
  end

  def highchart_download_icon
    ActionController::Base.helpers.image_path('download.svg')
  end

  def highchart_export_config
    {
      icon: highchart_download_icon,
      translations: {
        download_png: I18n.t('shared.chart_download.download_png'),
        download_jpeg: I18n.t('shared.chart_download.download_jpeg'),
        download_pdf: I18n.t('shared.chart_download.download_pdf'),
        download_svg: I18n.t('shared.chart_download.download_svg')
      }
    }
  end

  def set_reform_show_variables
    @active_reforms = Reform.active_reforms_array
    @active_verdicts = Verdict.active_verdicts_array
    @methodology_government = PageContent.find_by(name: 'methodology_government')
    @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
    @outcome = PageContent.find_by(name: 'outcome')
    @news = @reform_survey.news
    @stakeholders = Expert.stakeholders.by_reform(@reform.id).active.sorted

    gon.linked_reforms_verdicts = Verdict.linked_reforms
    gon.chart_download = highchart_export_config
    gon.change_icons = view_context.change_icons

    @verdict_ids = Verdict.with_reform(@reform.id).published.recent.pluck(:id)

    government_time_series = Chart.new(
      Verdict.reform_survey_data_for_charting(
        @reform.id,
        type: 'government',
        id: 'reform-government-history',
        verdict_ids: @verdict_ids
      ),
      request.path
    )

    stakeholder_time_series = Chart.new(
      Verdict.reform_survey_data_for_charting(
        @reform.id,
        type: 'stakeholder',
        id: 'reform-stakeholder-history',
        verdict_ids: @verdict_ids
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
      color: government_color,
      title: I18n.t('shared.categories.initial_setup'),
      score: @reform_survey.government_category1_score.to_f,
      change: @reform_survey.government_category1_change
    })

    government_capacity_gauge = Chart.new({
      id: 'reform-government-capacity-building',
      color: government_color,
      title: I18n.t('shared.categories.capacity_building'),
      score: @reform_survey.government_category2_score.to_f,
      change: @reform_survey.government_category2_change
    })

    government_infrastructure_gauge = Chart.new({
      id: 'reform-government-infrastructure-budgeting',
      color: government_color,
      title: I18n.t('shared.categories.infastructure_budgeting'),
      score: @reform_survey.government_category3_score.to_f,
      change: @reform_survey.government_category3_change
    })

    government_legislation_gauge = Chart.new({
      id: 'reform-government-legislation-regulations',
      color: government_color,
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
        verdict: @verdict.title
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
        verdict: @verdict.title
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
  end

  ##############################################
  # Authorization #

  # role is either the name of the role (string) or an array of role names (string)
  def valid_role?(role)
    redirect_to root_path(locale: I18n.locale), :notice => t('shared.msgs.not_authorized') if !current_user || !((role.is_a?(String) && current_user.is?(role)) || (role.is_a?(Array) && role.include?(current_user.role.name)))
  end

  rescue_from CanCan::AccessDenied do |_exception|
    if user_signed_in?
      not_authorized(root_path(locale: I18n.locale))
    else
      not_authorized
    end
  end

  def not_authorized(redirect_path = new_user_session_path)
    redirect_to redirect_path, alert: t('shared.msgs.not_authorized')
  rescue ActionController::RedirectBackError
    redirect_to root_path(locale: I18n.locale)
  end

  def not_found(redirect_path = root_path(locale: I18n.locale))
    Rails.logger.debug('Not found redirect')
    redirect_to redirect_path,
                notice: t('shared.msgs.does_not_exist')
  end
end
