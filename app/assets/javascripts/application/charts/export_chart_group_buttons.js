function setupExportChartGroupButtons(charts) {
  $('.js-toggle-chart-group-export-menu').click(function() {
    var menuShowableID = $(this).data('shows-id');

    $('*[data-showable-by-id="' + menuShowableID + '"]').toggleClass('is-hidden');
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
      ).map(function() {
        return this.highchartsObject;
      });

      initializeExportChartGroupButton($exportButton, exportableCharts);
    }
  );
}
