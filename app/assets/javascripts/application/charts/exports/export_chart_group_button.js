function initializeExportChartsButton($exportButton, charts) {
  var exportType = $exportButton.data('export-type'),
      allowedTypes = ['image/png', 'image/jpeg', 'application/pdf', 'image/svg+xml'];

  if (!allowedTypes.includes(exportType)) {
    throw new Error('Export button has export-type that is not allowed');
  }

  var exportURL = Highcharts.merge(Highcharts.getOptions().exporting).url;

  var exportOptions;

  if (charts.length === 1) {

    exportOptions = charts[0].getExportOptions(exportType);

  } else {

    var chartGroup = initializeChartGroup(charts);

    exportOptions = {
      filename: 'Gauge_Charts_ReforMeter',
      type: exportType,
      svg: chartGroup.getSVG()
    };

  }

  function postExportRequest() {
    Highcharts.post(
      exportURL,
      exportOptions
    );
  };

  function closeContainerMenu() {
    $exportButton.parents('.js-act-as-chart-export-menu').addClass('is-hidden');
  }

  return {
    setup: function() {
      postExportRequest();
      closeContainerMenu();
    }
  }
}
