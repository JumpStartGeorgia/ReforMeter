var RMRichTextArea = (function() {
  var exports = {};
  var selector = '.js-become-rich-text-editor';

  exports.existsOnPage = function() {
    return $(selector).length > 0;
  }

  exports.load = function() {

    if (!gon.tinymce_config) {
      throw new Error('Tinymce config not available');
    }

    tinymce.remove();

    var tinymceOptions = {
      selector: selector
    };

    var tinymceDefaultConfig = gon.tinymce_config.default;

    // Add default config attributes to tinymce options
    for (var attrname in tinymceDefaultConfig) {
      tinymceOptions[attrname] = tinymceDefaultConfig[attrname];
    }

    tinyMCE.init(tinymceOptions);
  }

  return exports;
})();
