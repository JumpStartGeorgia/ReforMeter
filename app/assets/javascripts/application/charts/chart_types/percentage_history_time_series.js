function percentageHistoryTimeSeriesOptions(chartData) {
  var options = {
    exporting: {
      buttons: {
        contextButton: {
          y: -25
        }
      },
      chartOptions: {
        title: {
          text: chartData.title
        }
      }
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
