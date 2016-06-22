//= require tinymce

$(document).ready(function() {
  setupReformColorSelect();
  setupReformColorSelectChange();
  setQuarterFormQuarter();
  setupExpertsSelectAll();
});

$(document).on('page:change', function() {
  if ($( "textarea.tinymce" ).length) {
    if (!gon.tinymce_config) {
      throw new Error('Tinymce config not available');
    }

    tinymce.remove();

    var tinymceOptions = {selector: "textarea.tinymce"};
    var tinymceDefaultConfig = gon.tinymce_config.default;

    // Add default config attributes to tinymce options
    for (var attrname in tinymceDefaultConfig) { tinymceOptions[attrname] = tinymceDefaultConfig[attrname]; }
    tinyMCE.init(tinymceOptions);
  }
});
