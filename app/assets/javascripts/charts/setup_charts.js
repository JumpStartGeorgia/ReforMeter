function initializeHighchart($container) {
  var highchart = {}
  var chartType = $container.data('chart-type');
  var containerChartID = $container.data('id');
  var exportableByID = $container.data('exportable-by-id');

  function chartData() {
    return gon.charts.filter(function(chartData) {
      return chartData.id === containerChartID;
    })[0];
  }

  var highchartData = chartData();

  if (!highchartData) {
    throw new Error('No data for chart ' + containerChartID);
  }

  highchart.create = function() {
    highchart.exportableBy = function(exportChartGroupButtonID) {
      return exportableByID === exportChartGroupButtonID;
    }

    var options = Highcharts.merge(
      highchartsOptions(chartType, highchartData)
    );

    highchart.highchartsObject = new Highcharts.Chart($container[0], options);
  };

  return highchart;
}

function setupCharts() {
  var $charts = $('.js-become-highchart');

  if ($charts.length === 0) {
    return null;
  }

  setupDefaultOptions();

  var charts = $charts.map(function() {
    return initializeHighchart($(this));
  });

  $(charts).each(function() {
    this.create();
  });

  var $exportButtons = $('.js-export-chart-group');

  $exportButtons.each(
    function() {
      var $exportButton = $(this);
      exportButtonDataID = $exportButton.data('export-id');

      var exportableCharts = charts.filter(
        function() {
          return this.exportableBy(exportButtonDataID);
        }
      ).map(function() {
        return this.highchartsObject;
      });

      initializeExportChartGroupButton($exportButton, exportableCharts);
    }
  )
}
