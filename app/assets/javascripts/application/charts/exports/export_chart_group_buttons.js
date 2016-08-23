function setupExportChartGroupButtons(chartObjects) {
  $('.js-toggle-chart-group-export-menu').click(function() {
    $(this)
    .parents('.js-act-as-chart-export-container')
    .find('.js-act-as-chart-export-menu')
    .toggleClass('is-hidden');
  });

  var $exportButtons = $('.js-export-chart-group');

  $exportButtons.each(
    function() {
      var $exportButton = $(this);
      var exportButtonDataID = $exportButton.data('export-id');

      var chartObject = chartObjects.filter(
        function(chartObject) {
          return chartObject.exportableBy(exportButtonDataID);
        }
      )[0];

      var exportChartButton = initializeExportChartsButton($exportButton, chartObject);

      exportChartButton.setup();
    }
  );
}
