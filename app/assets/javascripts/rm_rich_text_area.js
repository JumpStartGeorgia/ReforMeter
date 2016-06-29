var RMRichTextArea = (function() {
  var exports = {};
  var selector = '.js-become-rich-text-editor';

  exports.load = function() {

    $(selector).each(
      function() {
        CKEDITOR.replace($(this).attr('id'));
      }
    );

  }

  return exports;
})();
