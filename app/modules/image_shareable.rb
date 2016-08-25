module ImageShareable
  def png_image_exists?
    return false if page_path.blank?
    matching_image_paths.present?
  end

  # If image exists, returns the image's path.
  # Otherwise, generates a path for a new image.
  def png_image_path
    name = if (png_image_exists?)
      File.basename(matching_image_paths[0])
    else
      png_image_name_new
    end

    Pathname.new(images_dir_path_for_page).join(name).to_s
  end

  private

  def remove_forward_slash(str)
    str[0] === '/' ? str.slice(1, str.length) : str
  end

  def images_dir_path_for_page
    Pathname.new(ChartImages.images_dir).join(
      remove_forward_slash(page_path)
    ).to_s
  end

  def matching_image_paths
    Dir.glob(
      Rails.public_path.join(
        images_dir_path_for_page,
        png_image_name_glob
      )
    )
  end

  def png_image_name_new
    require 'securerandom'

    "#{png_image_name_base}_id-#{SecureRandom.hex}.png"
  end

  def png_image_name_glob
    "#{png_image_name_base}_id-*.png"
  end

  def png_image_name_base
    id
  end

  def full_png_image_path
    Rails.public_path.join(
      png_image_path
    ).to_s
  end
end
