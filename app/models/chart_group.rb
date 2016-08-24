class ChartGroup
  def initialize(charts, args)
    @charts = charts
    @id = args[:id]
  end

  def to_hash
    {
      id: id,
      chart_ids: charts.map(&:id),
      png_image_path: ''
    }
  end

  def charts
    @charts
  end

  def id
    @id
  end
end
