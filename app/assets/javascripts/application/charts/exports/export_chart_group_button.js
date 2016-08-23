function initializeExportChartGroupButton($exportButton, charts) {
  var exportType = $exportButton.data('export-type'),
      allowedTypes = ['image/png', 'image/jpeg', 'application/pdf', 'image/svg+xml'];

  if (!allowedTypes.includes(exportType)) {
    throw new Error('Export button has not allowed type');
  }

  var chartGroup = initializeChartGroup(charts);

  function multipleChartExportOptions() {
    return {
      filename: 'Gauge_Charts_ReforMeter',
      type: exportType,
      svg: chartGroup.getSVG()
    };
  }

  function postExportRequest() {
    var exportOptions;

    if (charts.length === 1) {

      exportOptions = charts[0].getExportOptions(exportType);

    } else {

      exportOptions = multipleChartExportOptions();

    }

    Highcharts.post(
      Highcharts.merge(Highcharts.getOptions().exporting).url,
      exportOptions
    );
  };

  return {
    setup: function() {
      postExportRequest();
      $exportButton.parents('.js-act-as-chart-export-menu').addClass('is-hidden');
    }
  }
}
