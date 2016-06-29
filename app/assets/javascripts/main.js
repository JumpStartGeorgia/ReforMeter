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

function openExpertsTab() {
  // return if anchor tag does not match expert-{number}
  var anchor_tag = window.location.hash.substring(1);
  if (!/expert-(\d+)/.test(anchor_tag)) return false;

  $('.js-act-as-tab-list-button[data-selects-tab-content-panel-id="experts"]').click();
}

$(document).on('page:change', function() {
  setupTabs();

  if ($('body.root.experts').length > 0) openExpertsTab();

});
