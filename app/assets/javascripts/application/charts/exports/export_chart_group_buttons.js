function setupExportChartGroupButtons(charts) {
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

      var exportableCharts = charts.filter(
        function() {
          return this.exportableBy(exportButtonDataID);
        }
      );
      
      $exportButton.click(
        initializeExportChartsButton($exportButton, exportableCharts).setup
      )
    }
  );
}
