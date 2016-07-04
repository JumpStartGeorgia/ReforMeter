function setupReformSelects(colorfulReformsTimeSeries) {
  var $reformSelect = $('.js-filter-reforms-by-reform');
  var $quarterSelect = $('.js-filter-reforms-by-quarter');
  var chartObject = colorfulReformsTimeSeries.highchartsObject;


  var unselectedReformLineWidth = chartObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;

  function filterReformByReform(selectedReformName) {
    function updateReformLineWidth(series, width) {
      series.options.lineWidth = width;
      series.update(series.options);
    }

    chartObject.series.forEach(function(series) {
      if (series.name === selectedReformName) {
        updateReformLineWidth(series, selectedReformLineWidth);
      } else {
        updateReformLineWidth(series, unselectedReformLineWidth);
      }
    });
  }

  function filterReformByQuarter() {
    var quarterData = chartObject.series.map(function(series) {
      return series.data[0];
    });

    chartObject.tooltip.refresh(quarterData);
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
