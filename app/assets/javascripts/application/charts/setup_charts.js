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
    highchart.data = highchartData;

    highchart.getExportOptions = function(exportType) {

      function chartSpecificExportOptions() {
        if (!highchart.highchartsObject.userOptions.exporting) return {};

        return highchart.highchartsObject.userOptions.exporting.chartOptions;
      }

      var defaultExportOptions = {
        chart: {
          style: {
            fontFamily: 'sans-serif',
            fontSize: '9px'
          }
        },
        legend: {
          itemDistance: 70,
          x: -40
        }
      };

      return {
        filename: highchartData.title ? highchartData.title + '_ReforMeter' : 'ReforMeter_Chart',
        type: exportType,
        scale: 1,
        svg: highchart.highchartsObject.getSVG(
          Highcharts.merge(
            defaultExportOptions,
            chartSpecificExportOptions()
          )
        )
      };
    }
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

  postCreateChartImages($.makeArray(charts), 'png');

  setupExportChartGroupButtons(charts);

  return charts;
}
