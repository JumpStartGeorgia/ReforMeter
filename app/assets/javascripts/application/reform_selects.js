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
