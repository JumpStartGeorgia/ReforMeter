class ChartGroup
  include ImageShareable

  def initialize(charts, args)
    @charts = charts
    @id = args[:id]
    @page_path = args[:page_path]
  end

  def to_hash
    hash = {
      id: id,
      chart_ids: charts.map(&:id),
    }

    if page_path.present? && !png_image_exists?
      hash[:png_image_path] = full_png_image_path
    end

    hash
  end

  def charts
    @charts
  end

  def id
    @id
  end

  private

  def page_path
    @page_path
  end
end
