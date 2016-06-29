var RMRichTextArea = (function() {
  var exports = {};
  var selector = '.js-become-rich-text-editor';

  exports.existsOnPage = function() {
    return $(selector).length > 0;
  }

  exports.load = function() {

    $(selector).each(
      function() {
        CKEDITOR.replace($(this).attr('id'));
      }
    );

  }

  return exports;
})();
