function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    chart: {
      marginTop: externalIndicatorChart.marginTop
    },
    colors: [
      '#db220f',
      '#e56024',
      '#ef9d38',
      '#f6c646',
      '#de3716',
      '#e8742b',
      '#f2b23f',
      '#e24b1d',
      '#ec8931',
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
