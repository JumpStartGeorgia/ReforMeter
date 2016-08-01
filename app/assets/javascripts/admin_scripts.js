//= require cocoon
//= require_tree ./admin/

(function() {

  $(document).ready(function() {
    setupReformColorSelect();
    setupReformColorSelectChange();
    setQuarterFormQuarter();
    setupExpertsSelectAll();
    setupExternalIndicatorType();
    setupExternalIndicatorCocoon();
    setupExternalIndicatorMove();
  });

  $(document).on('page:change', function() {
    RMRichTextArea.load();
  });

})();
