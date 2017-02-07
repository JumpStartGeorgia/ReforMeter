function setupReformSelects(colorfulReformsTimeSeries) {
  var chartObject = colorfulReformsTimeSeries.highchartsObject;
  var chartsTable = initializeChartsTable();

  var unselectedReformLineWidth = chartObject.series[0].options.lineWidth;
  var selectedReformLineWidth = 10;

  var verdict;
  var reform;

  function updateTooltip() {
    if (!verdict) {
      chartObject.tooltip.hide();
      return;
    }

    var tooltipData = [];

    chartObject.series.forEach(function(series) {
      if (reform && reform !== series.name) return;

      series.data.forEach(function(point) {
        if (!point.y) return;
        if (point.verdict_name !== verdict) return;

        tooltipData.push(point);
      });
    });

    if (tooltipData.length === 0) {
      chartObject.tooltip.hide();
    } else {
      chartObject.tooltip.refresh(tooltipData);
    }
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

  function initializeVerdictSelect() {
    var exports = {};
    var $verdictSelect = $('.js-filter-reforms-by-verdict');

    exports.setup = function() {
      $verdictSelect.on(
        'change',
        filterReformByVerdict
      );
    }

    function filterReformByVerdict() {
      var selectedOption = $verdictSelect.find(":selected");

      if (!selectedOption.attr('value')) {
        verdict = undefined;
      } else {
        verdict = selectedOption.text().trim();
      }

      updateTooltip();

      chartsTable.filter({
        verdict: verdict
      });
    }

    return exports;
  }

  var reformSelect = initializeReformSelect();
  var verdictSelect = initializeVerdictSelect();

  reformSelect.setup();
  verdictSelect.setup();
}
