class ChartImageObserver < ActiveRecord::Observer

  observe ActiveRecord::Base.send(:subclasses)

  def after_save(_)
    require 'fileutils'

    FileUtils.rm_r full_images_dir_path, force: :true
  end

  private

  # This method info is duplicated in Chart class; should be placed in module
  # and included here and in Chart class
  def full_images_dir_path
    Rails.public_path.join(
      ChartImages.images_dir
    ).to_s
  end
end
