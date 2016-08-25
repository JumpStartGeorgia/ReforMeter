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

    var chartElements = charts.map(function(chart, index) {
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

      return chartElement;
    });

    function titleElement(title) {
      var titleElement = '<text>' + title + '</text>';

      return titleElement;
    }

    function groupedChartElements(chartElements, titleElement) {
      return '<g>' + chartElements.join('') + '</g>';
    }

    titleElement = titleElement(title)
    groupedChartElements = groupedChartElements(chartElements, titleElement);

    if (typeof title === 'string') svgElements.push(titleElement);
    svgElements.push(groupedChartElements);

    var chartGroupSVGContent = svgElements.join('');

    function surroundWithSVG(content) {
      return '<svg height="'+ height + '" width="' + xOffset + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    return surroundWithSVG(chartGroupSVGContent);
  }

  chartGroup.getExportOptions = function(exportType) {
    var svg = getSVG();

    return {
      filename: title ? title + '_ReforMeter' : 'Gauge_Charts_ReforMeter',
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
