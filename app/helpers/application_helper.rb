# General helpers for application views
module ApplicationHelper
  def page_title(page_title)
    content_for(:page_title) { page_title.html_safe }
  end

  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def full_url(path)
    "#{request.protocol}#{request.host_with_port}#{path}"
  end

  # apply the strip_tags helper and also convert nbsp to a ' '
  def strip_tags_nbsp(text)
    if text.present?
      strip_tags(text.gsub('&nbsp;', ' '))
    end
  end

  # from http://www.kensodev.com/2012/03/06/better-simple_format-for-rails-3-x-projects/
  # same as simple_format except it does not wrap all text in p tags
  def simple_format_no_tags(text, _html_options = {}, options = {})
    text = '' if text.nil?
    text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    #   text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.html_safe
  end

  def change_icons
    return CHANGE_ICONS
  end

  # value = -1 -> down arrow
  # value =  0 -> flat arrow
  # value =  1 -> up arrow
  def generate_change_icon(change_value)
    CHANGE_ICONS[change_value.to_s.to_sym]
  end

  private

  CHANGE_ICONS = {
    '-1': ActionController::Base.helpers.image_tag(ActionController::Base.helpers.image_path('arrow_down.svg'), title: I18n.t('shared.change_status.down'), style: 'max-width: 100%; max-height: 100%;'),
    '0': ActionController::Base.helpers.image_tag(ActionController::Base.helpers.image_path('arrow_flat.svg'), title: I18n.t('shared.change_status.flat'), style: 'max-width: 100%; max-height: 100%;'),
    '1': ActionController::Base.helpers.image_tag(ActionController::Base.helpers.image_path('arrow_up.svg'), title: I18n.t('shared.change_status.up'), style: 'max-width: 100%; max-height: 100%;')
  }
end
