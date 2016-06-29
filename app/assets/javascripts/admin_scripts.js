//= require ckeditor/init

$(document).ready(function() {
  setupReformColorSelect();
  setupReformColorSelectChange();
  setQuarterFormQuarter();
  setupExpertsSelectAll();
});

$(document).on('page:change', function() {
  if (RMRichTextArea.existsOnPage()) {
    RMRichTextArea.load();
  }
});
