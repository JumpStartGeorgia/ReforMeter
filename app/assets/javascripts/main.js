$(document).ready(function() {
  setup_navigation_menu();
  setupSelect2();
  setupExpertTimePeriodSelect();
  makeReformPageChangeable();
  setupCharts();

  if ($("body").hasClass("root download_data_and_reports")) {
    activate_download_events();
  }
});

$(document).on('page:change', function() {
  setupTabs();

  if ($('body.root.experts').length > 0) openExpertsTab();
});
