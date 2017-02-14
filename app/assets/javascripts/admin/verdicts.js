function setupVerdictDatePicker() {
  if($('input#verdict_time_period').length > 0){
    // load the date pickers
    $('#verdict_time_period').datepicker({
        dateFormat: 'yy-mm-dd',
    });

    if (gon.time_period !== undefined &&
        gon.time_period.length > 0)
    {
      $("#verdict_time_period").datepicker("setDate", new Date(gon.time_period));
    }
  }
 
}


