$(document).ready(function() {
  setup_navigation_menu();
  setupSelect2();
  setupExpertTimePeriodSelect();
  makeReformPageChangeable();
  
  if ($("body").hasClass("root download_data_and_reports")) {
    activate_download_events();
  }
});
