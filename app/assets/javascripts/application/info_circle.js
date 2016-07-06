function initializeInfoCircles() {
  var exports = {},
      selector = '.js-act-as-info-circle';

  exports.setup = function() {
    $(selector).each(function() {
      var dataGravity = $(this).data('tipsy-gravity');
      var gravity = dataGravity ? dataGravity : $.fn.tipsy.autoNS;

      $(this).tipsy(
        {
          gravity: gravity,
          opacity: 1
        }
      );
    });

  }

  return exports;
}
