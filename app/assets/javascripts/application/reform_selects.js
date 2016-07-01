function setupReformSelects(colorfulReformsTimeSeries) {
  $('.js-filter-reforms-by-reform').on(
    'change',
    function() {
      var selectedReformName = $(this).find(":selected").text().trim();

      var reformsChartSelectedReformSeries = colorfulReformsTimeSeries.highchartsObject.series.filter(
        function(series) {
          return series.name === selectedReformName;
        }
      )[0];

      reformsChartSelectedReformSeries.options.lineWidth = 10;
      reformsChartSelectedReformSeries.update(reformsChartSelectedReformSeries.options);
    }
  )
}
