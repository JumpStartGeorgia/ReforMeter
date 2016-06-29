//= require tinymce

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
