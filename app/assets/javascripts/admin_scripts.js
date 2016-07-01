//= require ckeditor/init
//= require rm_rich_text_area

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
