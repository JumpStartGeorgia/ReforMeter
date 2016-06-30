//= require ckeditor/init

(function() {

  $(document).ready(function() {
    setupReformColorSelect();
    setupReformColorSelectChange();
    setQuarterFormQuarter();
    setupExpertsSelectAll();
  });

  $(document).on('page:change', function() {
    RMRichTextArea.load();
  });

})();
