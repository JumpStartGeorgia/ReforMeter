function setupReformSelects(colorfulReformsTimeSeries) {
  var $reformSelect = $('.js-filter-reforms-by-reform');
  var $quarterSelect = $('.js-filter-reforms-by-quarter');


  var unselectedReformLineWidth = colorfulReformsTimeSeries.highchartsObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;

  function filterReformByReform(selectedReformName) {
    function updateReformLineWidth(series, width) {
      series.options.lineWidth = width;
      series.update(series.options);
    }

    colorfulReformsTimeSeries.highchartsObject.series.forEach(function(series) {
      if (series.name === selectedReformName) {
        updateReformLineWidth(series, selectedReformLineWidth);
      } else {
        updateReformLineWidth(series, unselectedReformLineWidth);
      }
    });
  }

  function filterReformByQuarter() {
  }

  $reformSelect.on(
    'change',
    function() {
      var selectedReformName = $(this).find(":selected").text().trim();
      filterReformByReform(selectedReformName);
    }
  );

  $quarterSelect.on('change', filterReformByQuarter);
}
