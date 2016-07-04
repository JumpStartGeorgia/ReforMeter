function setupReformSelects(colorfulReformsTimeSeries) {
  var chartObject = colorfulReformsTimeSeries.highchartsObject;
  var chartsTable = initializeChartsTable();

  var unselectedReformLineWidth = chartObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;

  var quarter;
  var reform;

  function updateTooltip() {
    if (!quarter) {
      chartObject.tooltip.hide();
      return;
    }

    function pointMatchesQuarter(point) {
      return point.quarter_name === quarter;
    }

    function getQuarterPointOfSeries(series) {
      return series.data.filter(pointMatchesQuarter)[0];
    }

    var quarterData;
    quarterData = chartObject.series.map(getQuarterPointOfSeries);
    chartObject.tooltip.refresh(quarterData);
  }

  function selectedText($select) {
    return $select.find(":selected").text().trim();
  }

  function initializeReformSelect() {
    var exports = {};
    var $reformSelect = $('.js-filter-reforms-by-reform');

    function filterReformByReform() {
      var selectedOption = $reformSelect.find(":selected");

      if (!selectedOption.attr('value')) {
        reform = undefined;
      } else {
        reform = selectedOption.text().trim();
      }

      function updateReformLineWidth(series, width) {
        series.options.lineWidth = width;
        series.update(series.options);
      }

      chartObject.series.forEach(function(series) {
        if (series.name === reform) {
          updateReformLineWidth(series, selectedReformLineWidth);
        } else {
          updateReformLineWidth(series, unselectedReformLineWidth);
        }
      });

      updateTooltip();

      chartsTable.filter({
        reform: reform
      });
    }

    exports.setup = function() {
      $reformSelect.on(
        'change',
        filterReformByReform
      );
    }

    return exports;
  }

  function initializeQuarterSelect() {
    var exports = {};
    var $quarterSelect = $('.js-filter-reforms-by-quarter');

    exports.setup = function() {
      $quarterSelect.on(
        'change',
        filterReformByQuarter
      );
    }

    function filterReformByQuarter() {
      var selectedOption = $quarterSelect.find(":selected");

      if (!selectedOption.attr('value')) {
        quarter = undefined;
      } else {
        quarter = selectedOption.text().trim();
      }

      updateTooltip();

      chartsTable.filter({
        quarter: quarter
      });
    }

    return exports;
  }

  var reformSelect = initializeReformSelect();
  var quarterSelect = initializeQuarterSelect();

  reformSelect.setup();
  quarterSelect.setup();
}
