function setupReportDatePicker() {
  if($('input#report_report_date').length > 0){
    // load the date pickers
    $('#report_report_date').datepicker({
        dateFormat: 'yy-mm-dd',
    });

    if (gon.report_date !== undefined &&
        gon.report_date.length > 0)
    {
      $("#report_report_date").datepicker("setDate", new Date(gon.report_date));
    }
  }
 
}


