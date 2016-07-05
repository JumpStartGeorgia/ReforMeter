function percentageColorfulReformsHistoryTimeSeriesOptions(chartData) {
  var options = {
    exporting: {
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
