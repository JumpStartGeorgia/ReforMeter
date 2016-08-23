class ChartGroup
  def initialize(charts, args)
    @charts = charts
    @id = args[:id]
  end

  def to_hash
    {
      id: id,
      chart_ids: charts.map(&:id)
    }
  end

  def charts
    @charts
  end

  def id
    @id
  end
end
