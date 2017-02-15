function styleBenchmarkLineIfExists(chartData) {
  var benchmarkSeriesProperties = {
    type: 'spline',
    color: '#3b2f76',
    lineWidth: 4,
    dashStyle: 'Solid'
  }

  var benchmarkSeries = chartData.series.filter(function(seriesObject) {
    return seriesObject.isBenchmark
  })[0]

  if (benchmarkSeries) {
    Object.assign(
      benchmarkSeries,
      benchmarkSeriesProperties
    )
  }
}
