// turn on the event handlers for the select options
// - get the select value and append it to the url before continuing with the link click
function activate_download_events() {
  
  $('a.reform').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&reform_id=' + $('select.reform').val());
  });

  $('a.external_indicator').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&external_indicator_id=' + $('select.external_indicator').val());
  });

  $('a.report').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&quarter=' + $('select.report').val());
  });

}

$(document).ready(function() {
  // Run only on home page
  if ($("body").hasClass("root download_data_and_reports")) {
    activate_download_events();
  }
});
