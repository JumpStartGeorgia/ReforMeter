function percentageColorfulReformsHistoryTimeSeriesOptions(chartData) {
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
