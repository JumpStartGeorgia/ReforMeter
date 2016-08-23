function initializeExportChartsButton($exportButton, chartObject) {
  var exportChartButton = {};

  var exportType = $exportButton.data('export-type'),
      allowedTypes = ['image/png', 'image/jpeg', 'application/pdf', 'image/svg+xml'];

  if (!allowedTypes.includes(exportType)) {
    throw new Error('Export button has export-type that is not allowed');
  }

  var exportURL = Highcharts.merge(Highcharts.getOptions().exporting).url;
  var exportOptions = chartObject.getExportOptions(exportType);

  function postExportRequest() {
    Highcharts.post(
      exportURL,
      exportOptions
    );
  };

  function closeContainerMenu() {
    $exportButton.parents('.js-act-as-chart-export-menu').addClass('is-hidden');
  }

  exportChartButton.setup = function() {
    $exportButton.click(function() {
      postExportRequest();
      closeContainerMenu();
    });
  }

  return exportChartButton;
}
