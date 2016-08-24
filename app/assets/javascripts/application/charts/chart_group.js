function initializeChartGroup(charts, id, pngImagePath) {
  var chartGroup = {};

  function getSVG() {
    var svgArr = [],
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

      var svg = chart.highchartsObject.getSVG(
        Highcharts.merge(
          defaultExportOptions,
          chart.specificExportOptions()
        )
      );

      svg = svg.replace('<svg', '<g transform="translate(' + xOffset + ',0)" ');
      svg = svg.replace('</svg>', '</g>');

      svg = improveDataLabelStylesInGaugeSVGExport(
        svg,
        highchartsObject,
        {
          topPadding: index === 0 ? '.5em' : false
        }
      );

      height = parseInt(Math.max(height, highchartsObject.chartHeight));
      xOffset += parseInt(highchartsObject.chartWidth);

      svgArr.push(svg);
    });

    function surroundWithSVG(content) {
      return '<svg height="'+ height + '" width="' + xOffset + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    var svgObj = surroundWithSVG(svgArr.join(''));

    return svgObj;
  }

  chartGroup.getExportOptions = function(exportType) {
    return {
      filename: 'Gauge_Charts_ReforMeter',
      type: exportType,
      svg: getSVG()
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
