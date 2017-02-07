function initializeChartsTable() {
  var exports = {};
  var selectedVerdict;
  var selectedReform;

  function initializeRow($row) {
    var exports = {};

    exports.show = function() {
      $row.removeClass('is-hidden');
    }

    exports.hide = function() {
      $row.addClass('is-hidden');
    }

    exports.hasVerdict = function(verdict) {
      return $row.find('.js-act-as-verdict-name').text().trim() === verdict;
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

    if (options.hasOwnProperty('verdict')) selectedVerdict = options.verdict;
    if (options.hasOwnProperty('reform')) selectedReform = options.reform;

    rows.each(
      function() {
        if (selectedVerdict && !this.hasVerdict(selectedVerdict)) this.hide();
        if (selectedReform && !this.hasReform(selectedReform)) this.hide();
      }
    );
  }

  return exports;
}
