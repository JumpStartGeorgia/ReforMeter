function initializeChartsTable() {
  var exports = {};

  function initializeRow($row) {
    var exports = {};

    exports.show = function() {
      $row.removeClass('is-hidden');
    }

    exports.hide = function() {
      $row.addClass('is-hidden');
    }

    exports.hasQuarter = function(quarter) {
      return $row.find('.js-act-as-quarter-name').text().trim() === quarter;
    }

    return exports;
  }

  var rows = $('.js-act-as-reform-table-row').map(
    function() {
      return initializeRow($(this));
    }
  );

  function reset() {
    rows.each(
      function() {
        this.show();
      }
    )
  }

  exports.filter = function(quarter) {
    reset();

    rows.each(
      function() {
        if (!this.hasQuarter(quarter)) this.hide();
      }
    );
  }

  return exports;
}
