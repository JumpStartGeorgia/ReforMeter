function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    chart: {
      marginTop: externalIndicatorChart.marginTop
    },
    colors: externalIndicatorChart.colors,
    exporting: {
      enabled: true
    },
    subtitle: externalIndicatorChart.subtitle(chartData.subtitle),
    title: externalIndicatorChart.title(chartData.title),
    yAxis: {
      title: {
        text: chartData.unitLabel
      }
    },
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
