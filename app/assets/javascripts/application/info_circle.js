function initializeInfoCircles() {
  var exports = {},
      $infoCircles = $('.js-act-as-info-circle');

  exports.setup = function() {
    $infoCircles.tipsy(
      {
        className: 'infoCircle-tooltip',
        gravity: $.fn.tipsy.autoNS,
        opacity: 1
      }
    );
  }

  return exports;
}
