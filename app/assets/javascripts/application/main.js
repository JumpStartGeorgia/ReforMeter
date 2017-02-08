(function() {
  $(document).ready(function() {
    setup_navigation_menu();
    setupSelect2();
    setupExpertTimePeriodSelect();
    initializeChangeReformPageControls().setup();
    initializeScrollToIdSelect().setup();
    var charts = setupCharts();

    initializeInfoCircles().setup();

    applyBrowserSpecificHacks();

    if ($('body.root.reforms').length > 0) {
      var colorfulReformsTimeSeries = charts.filter(function() {
        return $(this.highchartsObject.renderTo).data('id') === 'reforms-government-history-series';
      })[0];

      setupReformSelects(colorfulReformsTimeSeries);
    }

    if ($("body").hasClass("root download_data_and_reports")) {
      activate_download_events();
    }
  });

  $(document).on('page:change', function() {
    $('html').attr('lang', gon.locale);
    setupTabs();

    if ($('body.root.review_board').length > 0) openExpertsTab();
  });
})();
