function initializeExternalIndicatorIndexBoxes(chartData, seriesData) {
  var indexBoxesMethods = {};

  var $chart = $('*[data-id="' + chartData.id + '"]');
  var $indexesContainer = $chart.siblings('.js-act-as-chart-indexes-container');

  var indexBoxes = $indexesContainer.find('.js-act-as-index-box').map(
    function() {
      return initializeIndexBox(chartData.indexes, $(this), chartData.use_decimals);
    }
  );

  indexBoxesMethods.update = function(point) {
    $(indexBoxes).each(function() {
      this.update(point);
    });
  }

  return indexBoxesMethods;
}
