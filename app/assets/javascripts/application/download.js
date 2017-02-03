// turn on the event handlers for the select options
// - get the select value and append it to the url before continuing with the link click
function activate_download_events() {

  $('a.js-reform').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&reform_id=' + $('select.reform').val());
  });

  $('a.js-external_indicator').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&external_indicator_id=' + $('select.external_indicator').val());
  });

  $('a.js-report').on('click', function(){
    $(this).attr('href', $(this).attr('href') + '&report=' + $('select.report').val());
  });

}
