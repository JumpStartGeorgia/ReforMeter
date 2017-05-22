class AddMissingTranslation < ActiveRecord::Base
  self.abstract_class = true

  #######################
  ## CALLBACKS

  before_validation :set_missing_translations

  #######################
  #######################
  private

  # if there are any required translation fields that are missing values, add them
  def set_missing_translations
    default_locale = nil
    # check if default locale is ok
    Globalize.with_locale(I18n.default_locale) do
      if has_required_translations?(I18n.default_locale)
        default_locale = I18n.default_locale
      end
    end

    # if the default locale is not ok, look at other locales
    if default_locale.nil?
      locales = I18n.available_locales.clone
      locales.delete(I18n.default_locale)

      locales.each do |locale|
        Globalize.with_locale(locale) do
          if has_required_translations?(locale)
            default_locale = locale
          end
        end
        break if default_locale.present?
      end
    end

    # if found a good trans, go through the other locales and add missing data
    if default_locale.present?
      locales = I18n.available_locales.clone
      locales.delete(default_locale)

      locales.each do |locale|
        Globalize.with_locale(locale) do
          add_missing_translations(default_locale)
        end
      end
    end

  end

  # # if there are any required translation fields that are missing values, add them
  # def set_missing_translations
  #   default_trans = nil
  #   default_locale = nil
  #   # check if default locale is ok
  #   Globalize.with_locale(I18n.default_locale) do
  #     if has_required_translations?(I18n.default_locale)
  #       default_trans = self.clone
  #       default_locale = I18n.default_locale
  #     end
  #   end

  #   # if the default locale is not ok, look at other locales
  #   if default_trans.nil?
  #     locales = I18n.available_locales.clone
  #     locales.delete(I18n.default_locale)

  #     locales.each do |locale|
  #       Globalize.with_locale(locale) do
  #         if has_required_translations?(locale)
  #           default_trans = self.clone
  #           default_locale = locale
  #         end
  #       end
  #       break if default_trans.present?
  #     end
  #   end

  #   # if found a good trans, go through the other locales and add missing data
  #   if default_trans.present? && default_locale.present?
  #     locales = I18n.available_locales.clone
  #     locales.delete(default_locale)

  #     locales.each do |locale|
  #       Globalize.with_locale(locale) do
  #         add_missing_translations(default_locale)
  #       end
  #     end
  #   end

  # end

  # # this method needs to be overriden
  # def has_required_translations?(locale)
  # end

  # # this method needs to be overriden
  # def add_missing_translations(default_locale)
  # end


  def has_required_translations?(locale)
    exists = []
    puts "111111111111111 klass = #{self.class}; locale = #{locale}"
    required_translation_fields.each do |field|
      exists << self.send("#{field}_#{locale}").present?
    end

    puts "- has all required fields: #{!exists.include?(false)}"
    return !exists.include?(false)

    # puts "1111 ext ind has required for #{Globalize.locale} = #{trans.title.present?}"
    # trans.title.present?
  end

  def add_missing_translations(default_locale)
    puts "22222222222222 klass = #{self.class}"
    puts "-- default locale = #{default_locale}"
    locales = I18n.available_locales.clone
    locales.delete(default_locale)
    puts "-- locales = #{locales}"
    required_translation_fields.each do |field|
      locales.each do |locale|
        puts "- #{field}_#{locale} exists = #{!self.send("#{field}_#{locale}").blank?}; default = #{self.send("#{field}_#{default_locale}")}"
        self.send("#{field}_#{locale}=", self.send("#{field}_#{default_locale}")) if self.send("#{field}_#{locale}").blank?
      end
    end


    # puts "!!!!!!!! ext ind #{Globalize.locale} has no title #{self["title_#{Globalize.locale}"].blank?}"
    # puts "!!!!!!!! default title = #{default_trans.title}"
    # self.title = default_trans.title if self["title_#{Globalize.locale}"].blank?
    # puts "####### self attributes #{self.attributes.inspect}"
  end


  # this method needs to be overriden
  def required_translation_fields
    return []
  end


end