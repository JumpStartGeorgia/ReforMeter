function initializeScrollToIdSelect() {
  var exports = {};
  var $selector = $('.js-scroll-to-id');

  function scrollToId() {
    var selectedId = $selector.val();
    if(selectedId == 'default') 
      return;
    var $selectedIndicator = $('#' + selectedId);
    $selector.val('default').trigger('change');  
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
