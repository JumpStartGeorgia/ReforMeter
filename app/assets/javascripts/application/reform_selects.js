function initializeChartsTable() {
  var exports = {};

  function initializeRow($row) {
    var exports = {};

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

  exports.filter = function(quarter) {
    rows.each(
      function() {
        if (!this.hasQuarter(quarter)) this.hide();
      }
    );
  }

  return exports;
}

function setupReformSelects(colorfulReformsTimeSeries) {
  var $reformSelect = $('.js-filter-reforms-by-reform');
  var $quarterSelect = $('.js-filter-reforms-by-quarter');

  var chartObject = colorfulReformsTimeSeries.highchartsObject;
  var chartsTable = initializeChartsTable();

  var unselectedReformLineWidth = chartObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;

  function selectedText($select) {
    return $select.find(":selected").text().trim();
  }

  function filterReformByReform(selectedReformName) {
    function updateReformLineWidth(series, width) {
      series.options.lineWidth = width;
      series.update(series.options);
    }

    chartObject.series.forEach(function(series) {
      if (series.name === selectedReformName) {
        updateReformLineWidth(series, selectedReformLineWidth);
      } else {
        updateReformLineWidth(series, unselectedReformLineWidth);
      }
    });
  }

  function filterReformByQuarter(quarter) {
    function pointMatchesQuarter(point) {
      return point.quarter_name === quarter;
    }

    function getQuarterPointOfSeries(series) {
      return series.data.filter(pointMatchesQuarter)[0];
    }

    var quarterData = chartObject.series.map(getQuarterPointOfSeries);

    chartObject.tooltip.refresh(quarterData);
    chartsTable.filter(quarter);
  }

  $reformSelect.on(
    'change',
    function() {
      filterReformByReform(selectedText($(this)));
    }
  );

  $quarterSelect.on(
    'change',
    function() {
      filterReformByQuarter(selectedText($(this)));
    }
  );
}
