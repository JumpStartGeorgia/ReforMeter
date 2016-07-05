function initializeChartsTable() {
  var exports = {};
  var selectedQuarter;
  var selectedReform;

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

    exports.hasReform = function(reform) {
      return $row.find('.js-act-as-reform-name').text().trim() === reform;
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

  exports.filter = function(options) {
    reset();

    if (!options) return;

    if (typeof options !== 'object') {
      throw new Error('Charts table "filter" method should be invoked with an object as an argument.')
    }

    if (options.hasOwnProperty('quarter')) selectedQuarter = options.quarter;
    if (options.hasOwnProperty('reform')) selectedReform = options.reform;

    rows.each(
      function() {
        if (selectedQuarter && !this.hasQuarter(selectedQuarter)) this.hide();
        if (selectedReform && !this.hasReform(selectedReform)) this.hide();
      }
    );
  }

  return exports;
}
