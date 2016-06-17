function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    colors: externalIndicatorChart.colors,
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
