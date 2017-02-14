//= require twitter/bootstrap/transition
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/scrollspy
//= require twitter/bootstrap/tab
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/button
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/carousel
//= require twitter/bootstrap/affix
//= require jquery-ui/datepicker
//= require cocoon
//= require_tree ./admin/

(function() {

  $(document).ready(function() {
    setupReformColorSelect();
    setupReformColorSelectChange();
    setVerdictFormVerdict();
    setupExpertsSelectAll();
    setupExternalIndicatorType();
    setupExternalIndicatorCocoon();
    setupExternalIndicatorMove();
    setupExternalIndicatorInputs();
    setupExternalIndicatorBenchmark();
    setupExpertReformSelector();
    setupReportDatePicker();
    setupVerdictDatePicker();
    setupReformSurveyDatePicker();
  });

  $(document).on('page:change', function() {
    RMRichTextArea.load();
  });

})();
