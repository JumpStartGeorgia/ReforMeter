function highchartsExternalIndicatorBar(chartData) {
  var options = {
    title: {
      text: chartData.title
    }
  };

  return Highcharts.merge(options);
}
