function initializeChangeReformPageControls() {
  var exports = {};

  var $quarterSelect = $('.js-reform-page-quarter-select');
  var $reformSelect = $('.js-reform-page-reform-select');
  var $loadNewReformButton = $('.js-load-new-reform-page');

  function loadNewReform() {
    var newQuarter = $quarterSelect.val();
    var newReform = $reformSelect.val();
    var newURL = $(this).data('newUrlBase') + '/' + newReform + '/' + newQuarter;

    window.location.href = newURL;
  }

  exports.setup = function() {
    $loadNewReformButton.click(loadNewReform);
  }

  return exports;
}
