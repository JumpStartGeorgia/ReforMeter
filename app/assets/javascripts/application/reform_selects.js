function setupReformSelects(colorfulReformsTimeSeries) {
  var unselectedReformLineWidth = colorfulReformsTimeSeries.highchartsObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;



  function filterReform() {
    function updateReformLineWidth(series, width) {
      series.options.lineWidth = width;
      series.update(series.options);
    }

    var selectedReformName = $(this).find(":selected").text().trim();

    colorfulReformsTimeSeries.highchartsObject.series.forEach(function(series) {
      if (series.name === selectedReformName) {
        updateReformLineWidth(series, selectedReformLineWidth);
      } else {
        updateReformLineWidth(series, unselectedReformLineWidth);
      }
    });
  }

  $('.js-filter-reforms-by-reform').on('change', filterReform);
}
