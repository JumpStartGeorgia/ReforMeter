function ratingHistoryTimeSeriesOptions(chartData) {
  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80
    },
    exporting: {
      enabled: true
    },
    yAxis: {
      min: 0,
      max: 10,
      tickInterval: 1,
      plotBands: ratingTimeSeriesYAxisPlotBands(ratingPlotBands(chartData.color))
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}