function initializeHighchart($container, highchartData) {
  var highchart = {}
  var chartType = $container.data('chart-type');
  var exportableByID = $container.data('exportable-by-id');

  highchart.exportableBy = function(exportChartGroupButtonID) {
    return exportableByID === exportChartGroupButtonID;
  }

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

    // if chart is gauge, improve data label styles
    if (/gauge/.test(chartType)) {

      svg = improveDataLabelStylesInGaugeSVGExport(
        svg,
        this.highchartsObject,
        {
          topPadding: '0.7em'
        }
      );

    }

    return {
      filename: highchartData.title ? highchartData.title + '_ReforMeter' : 'ReforMeter_Chart',
      type: exportType,
      scale: 1,
      svg: svg
    };
  }

  highchart.data = highchartData;

  highchart.create = function() {
    var options = Highcharts.merge(
      highchartsOptions(chartType, highchartData)
    );

    highchart.highchartsObject = new Highcharts.Chart($container[0], options);
  };

  return highchart;
}
