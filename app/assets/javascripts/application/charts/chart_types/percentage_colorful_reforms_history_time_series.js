function percentageColorfulReformsHistoryTimeSeriesOptions(chartData) {
  var options = {
    chart: {
      spacingTop: 25
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
      },
      enabled: true
    },
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
