class Chart
  def initialize(options)
    @options = options
  end

  def to_hash
    hash = @options

    hash[:png_image_path] = png_image_path

    hash
  end

  private

  def png_image_path
    Rails.root.join(
      'public',
      'system',
      'chart_share_images',
      png_image_name
    ).to_s
  end

  def png_image_name
    'testsdf.png'
  end
end
