function percentageColorfulReformsHistoryTimeSeriesOptions(chartData) {
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
