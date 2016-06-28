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
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  ##############################################

  def set_global_vars
    # indicate which year can be the first year for data
    @quarter_start_year = 2015


    # if user_signed_in? && request.path.starts_with?("/#{I18n.locale}/admin/")
    gon.tinymce_config = YAML.load_file('config/tinymce.yml')
    # end
  end

  ##############################################
  # helpers

  def clean_filename(filename)
    filename.strip.to_slug.transliterate.to_s.gsub(' ', '_').gsub(/[\\ \/ \: \* \? \" \< \> \| \, \. ]/,'')
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
