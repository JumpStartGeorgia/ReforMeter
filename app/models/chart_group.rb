class ChartGroup
  include ImageShareable

  def initialize(charts, args)
    @charts = charts
    @id = args[:id]
    @page_path = args[:page_path]
    @title = args[:title]
  end

  def to_hash
    hash = {
      id: id,
      chart_ids: charts.map(&:id),
    }

    hash[:title] = title if title.present?

    if page_path.present? && !png_image_exists?
      hash[:png_image_path] = full_png_image_path
    end

    hash
  end

  attr_reader :charts, :id

  private

  attr_reader :page_path, :title
end
