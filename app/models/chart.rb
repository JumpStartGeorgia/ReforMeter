class Chart
  def initialize(options)
    @options = options
  end

  def to_hash
    hash = @options

    hash[:png_image_path] = png_image_path.to_s

    hash
  end

  private

  def png_image_path
    images_dir.join(
      page_path,
      png_image_name
    )
  end

  def page_path
    'en/review_board'
  end

  def images_dir
    Rails.root.join(
      'public',
      'system',
      'chart_share_images'
    )
  end

  def png_image_name
    "#{@options[:id]}.png"
  end
end
