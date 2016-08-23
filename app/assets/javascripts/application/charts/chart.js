function initializeHighchart($container, highchartData) {
  var highchart = {}
  var chartType = $container.data('chart-type');
  var exportableByID = $container.data('exportable-by-id');

  highchart.create = function() {
    highchart.exportableBy = function(exportChartGroupButtonID) {
      return exportableByID === exportChartGroupButtonID;
    }

    var options = Highcharts.merge(
      highchartsOptions(chartType, highchartData)
    );

    highchart.highchartsObject = new Highcharts.Chart($container[0], options);
    highchart.data = highchartData;

    highchart.specificExportOptions = function() {
      if (!this.highchartsObject.userOptions.exporting) return {};

      return this.highchartsObject.userOptions.exporting.chartOptions;
    }

    highchart.getExportOptions = function(exportType) {

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

      svg = highchart.highchartsObject.getSVG(
        Highcharts.merge(
          defaultExportOptions,
          highchart.specificExportOptions()
        )
      );

      return {
        filename: highchartData.title ? highchartData.title + '_ReforMeter' : 'ReforMeter_Chart',
        type: exportType,
        scale: 1,
        svg: svg
      };
    }
  };

  return highchart;
}
