function initializeInfoCircles() {
  var exports = {},
      $infoCircles = $('.js-act-as-info-circle');

  exports.setup = function() {
    $infoCircles.tipsy(
      {
        gravity: $.fn.tipsy.autoNS,
        html: true,
        opacity: 1
      }
    );
  }

  return exports;
}
