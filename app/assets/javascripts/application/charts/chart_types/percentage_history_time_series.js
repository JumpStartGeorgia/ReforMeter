function percentageHistoryTimeSeriesOptions(chartData) {
  var options = {
    exporting: {
      chartOptions: {
        title: {
          text: chartData.title
        }
      },
      enabled: true
    },
    yAxis: {
      min: 0,
      max: 100,
      minorTickInterval: 'auto',
      tickInterval: 50
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
