function smallRatingHistoryTimeSeriesOptions(chartData) {
  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80
    },
    legend: {
      enabled: false
    },
    yAxis: {
      max: 10,
      min: 0,
      plotBands: customTimeSeriesPlotBands(ratingPlotBands(chartData.color)),
      tickInterval: 1
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
