function initializeChartGroup(charts, id, pngImagePath, options) {
  var chartGroup = {};
  var title = options.title;

  function getSVG() {
    var svgElements = [],
        height = 0,
        xOffset = 0;

    var chartGroupHeight = $.makeArray(charts).reduce(
      function(biggestHeight, chart) {
        return Math.max(biggestHeight, chart.highchartsObject.chartHeight);
      },
      0
    );

    $.each(charts, function(index, chart) {
      var highchartsObject = chart.highchartsObject;

      var defaultExportOptions = {
        chart: {
          backgroundColor: 'white',
          height: parseInt(chartGroupHeight),
          style: {
            fontFamily: 'sans-serif',
            fontSize: '9.5px'
          },
          width: parseInt(highchartsObject.chartWidth)
        }
      }

      var chartElement = chart.highchartsObject.getSVG(
        Highcharts.merge(
          defaultExportOptions,
          chart.specificExportOptions()
        )
      );

      chartElement = chartElement.replace('<svg', '<g transform="translate(' + xOffset + ',0)" ');
      chartElement = chartElement.replace('</svg>', '</g>');

      chartElement = improveDataLabelStylesInGaugeSVGExport(
        chartElement,
        highchartsObject,
        {
          topPadding: index === 0 ? '.5em' : false
        }
      );

      height = parseInt(Math.max(height, highchartsObject.chartHeight));
      xOffset += parseInt(highchartsObject.chartWidth);

      svgElements.push(chartElement);
    });

    function surroundWithSVG(content) {
      return '<svg height="'+ height + '" width="' + xOffset + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    var svgObj = surroundWithSVG(svgElements.join(''));

    return svgObj;
  }

  chartGroup.getExportOptions = function(exportType) {
    var svg = getSVG();

    return {
      filename: 'Gauge_Charts_ReforMeter',
      type: exportType,
      scale: imageScaleForSVG(svg),
      svg: svg
    };
  }

  chartGroup.exportableBy = function(exportButtonDataID) {
    return id === exportButtonDataID;
  }

  Object.defineProperty(
    chartGroup,
    'png_image_path',
    {
      get: function() {
        if (pngImagePath) {
          return pngImagePath;
        } else {
          return false;
        }
      }
    }
  )

  return chartGroup;
}
