module ChartImages
  def self.images_dir
    'system/chart_images'
  end

  def self.full_images_dir
    Rails.public_path.join(self.images_dir).to_s
  end

  # Checks that path is to file in full_images_dir
  # (It does not matter if file exists yet)
  def self.is_parent_dir_of_path(path)
    (path =~ /^#{self.full_images_dir}/).present?
  end
end
