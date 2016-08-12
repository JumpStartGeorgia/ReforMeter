function initializeScrollToIdSelect() {
  var exports = {};
  var $selector = $('.js-scroll-to-id');

  function scrollToId() {
    var selectedId = $selector.val();
    var $selectedIndicator = $('#' + selectedId);

    window.location.hash = selectedId;

    $('html, body').animate(
      {
        scrollTop: $selectedIndicator.offset().top
      },
      1500
    );
  }

  exports.setup = function() {
    $selector.change(scrollToId);
  }

  return exports;
}
