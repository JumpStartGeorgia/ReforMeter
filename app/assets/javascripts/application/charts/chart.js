function initializeHighchart($container, highchartData) {
  var highchart = {};
  var svg;
  var filename;
  var chartType = $container.data('chart-type');
  var exportableByID = $container.data('exportable-by-id');
  var id = $container.data('id');

  Object.defineProperty(
    highchart,
    'id',
    {
      get: function() {
        return id;
      }
    }
  )

  Object.defineProperty(
    highchart,
    'png_image_path',
    {
      get: function() {
        if (highchartData.png_image_path) {
          return highchartData.png_image_path;
        } else {
          return false;
        }
      }
    }
  )

  highchart.exportableBy = function(exportChartGroupButtonID) {
    return exportableByID === exportChartGroupButtonID;
  }

  highchart.specificExportOptions = function() {
    if (!this.highchartsObject.userOptions.exporting) return {};

    return this.highchartsObject.userOptions.exporting.chartOptions;
  }

  function getSVG() {
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

    var svg = highchart.highchartsObject.getSVG(
      Highcharts.merge(
        defaultExportOptions,
        highchart.specificExportOptions()
      )
    );

    // if chart is gauge, improve data label styles
    if (/gauge/.test(chartType)) {

      svg = improveDataLabelStylesInGaugeSVGExport(
        svg,
        highchart.highchartsObject,
        {
          topPadding: '0.7em'
        }
      );

    }

    return svg;
  }

  function getFilename() {
    return highchartData.title ? highchartData.title + ' - ReforMeter' : 'Chart - ReforMeter';
  }

  highchart.getExportOptions = function(exportType) {
    if (!svg) svg = getSVG();
    if (!filename) filename = getFilename();

    return {
      filename: encodeURIComponent(filename),
      type: exportType,
      scale: imageScaleForSVG(svg),
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
