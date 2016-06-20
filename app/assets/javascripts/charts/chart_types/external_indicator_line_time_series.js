function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    chart: {
      marginTop: externalIndicatorChart.marginTop
    },
    colors: [
      '#db220f',
      '#de3716',
      '#e24b1d',
      '#e56024',
      '#e8742b',
      '#ec8931',
      '#ef9d38',
      '#f2b23f',
      '#f2b23f',
      '#f6c646'
    ],
    exporting: {
      enabled: true
    },
    subtitle: externalIndicatorChart.subtitle(chartData.subtitle),
    title: externalIndicatorChart.title(chartData.title),
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
