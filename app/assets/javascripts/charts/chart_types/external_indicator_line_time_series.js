function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    exporting: {
      enabled: true
    },
    yAxis: {
      title: {
        text: 'Percentage'
      }
    },
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
