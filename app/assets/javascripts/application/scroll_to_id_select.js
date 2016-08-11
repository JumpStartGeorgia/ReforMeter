function initializeScrollToIdSelect() {
  var exports = {};
  var $selector = $('.js-scroll-to-id');

  exports.setup = function() {
    $selector.change(function() {
      var $selectedIndicator = $('#' + $selector.val());

      $('html, body').animate(
        {
          scrollTop: $selectedIndicator.offset().top
        },
        1500
      );
    });
  }

  return exports;
}
