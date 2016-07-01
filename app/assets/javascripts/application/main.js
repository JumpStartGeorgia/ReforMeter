(function() {
  $(document).ready(function() {
    setup_navigation_menu();
    setupSelect2();
    setupExpertTimePeriodSelect();
    makeReformPageChangeable();
    var charts = setupCharts();

    if ($('body.root.reforms').length > 0) {
      var colorfulReformsTimeSeries = charts.filter(function() {
        return $(this.highchartsObject.renderTo).data('id') === 'reforms-history-series';
      })[0];

      setupReformSelects(colorfulReformsTimeSeries);
    }

    if ($("body").hasClass("root download_data_and_reports")) {
      activate_download_events();
    }
  });

  $(document).on('page:change', function() {
    setupTabs();

    if ($('body.root.experts').length > 0) openExpertsTab();
  });
})();
