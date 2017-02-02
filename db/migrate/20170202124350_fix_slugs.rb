class FixSlugs < ActiveRecord::Migration
  def up
    # update the quarter and reform ka slugs
    locale_was = I18n.locale

    I18n.available_locales.each do |locale|
      I18n.locale = locale
      
      Reform.all.each do |r|
        r.slug = r.slug.to_url
        r.save
      end

      Quarter.all.each do |q|
        q.slug = q.slug.to_url
        q.save
      end
    end

    I18n.locale = locale_was

    # erase all existing chart images
    path = "#{Rails.root}/public/system/chart_images"
    FileUtils.rm_r(path) if File.exists? path
    
  end

  def down
    puts 'do nothing'
  end 
end
