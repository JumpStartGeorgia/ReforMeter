# This model is primarily used for making charts shareable, i.e.
# generating a path to an image for the chart and then providing that path
# as necessary.
#
# Note: Just in case facebook (or a different social media site) caches
# image names, the chart images are generated with a random ID in the name.
class Chart
  include ImageShareable

  def initialize(options, page_path = nil)
    @options = options
    @id = options[:id]
    @page_path = page_path if (page_path.present?)
  end

  def to_hash
    hash = options

    if page_path.present? && !png_image_exists?
      hash[:png_image_path] = full_png_image_path
    end

    hash
  end

  attr_reader :id

  private

  attr_reader :page_path, :options
end
