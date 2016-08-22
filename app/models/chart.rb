class Chart
  def initialize(options, page_path)
    @options = options
    @page_path = page_path
  end

  def to_hash
    hash = @options

    hash[:png_image_path] = full_png_image_path unless png_image_exists?

    hash
  end

  def png_image_exists?
    File.exist?(full_png_image_path)
  end

  def png_image_path
    Pathname.new(images_dir_path_for_page).join(
      png_image_name
    ).to_s
  end

  private

  def remove_forward_slash(str)
    str[0] === '/' ? str.slice(1, str.length) : str
  end

  def full_png_image_path
    Rails.public_path.join(
      png_image_path
    ).to_s
  end

  def page_path
    @page_path
  end

  def images_dir_path_for_page
    Pathname.new(ChartImages.images_dir).join(
      remove_forward_slash(page_path)
    ).to_s
  end

  def png_image_name
    "#{@options[:id]}.png"
  end
end
