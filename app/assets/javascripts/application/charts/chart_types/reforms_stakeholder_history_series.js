function reformsStakeholderHistorySeriesOptions(chartData) {
  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80
    },
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
    legend: {
      enabled: chartData.series.length > 1
    },
    yAxis: {
      min: 0,
      max: 10,
      tickInterval: 1,
      plotBands: customTimeSeriesPlotBands(ratingPlotBands(chartData))
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
