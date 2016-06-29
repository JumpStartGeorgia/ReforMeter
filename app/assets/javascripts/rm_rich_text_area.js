var RMRichTextArea = (function() {
  var exports = {};
  var selector = '.js-become-rich-text-editor';

  exports.load = function() {

    // Get already loaded instances
    var loaded_instances = Object.getOwnPropertyNames(CKEDITOR.instances);

    $(selector).each(
      function() {

        var editor_id = $(this).attr('id');

        // Remove CKEditor instance if already loaded.
        // Necessary for compatibility with Turbolinks restoration visits,
        // in which the instances are not removed
        if (loaded_instances.includes(editor_id)) {
          CKEDITOR.remove(CKEDITOR.instances[editor_id]);
        }

        // Initialize CKEditor instance
        CKEDITOR.replace($(this).attr('id'));
      }
    );

  }

  return exports;
})();
