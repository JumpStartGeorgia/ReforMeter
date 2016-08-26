function initializeChartGroup(charts, id, pngImagePath, options) {
  var chartGroup = {};
  var svg;
  var title = options.title;
  var subtitle = options.subtitle;

  function filename() {
    var filename_prefix;

    if (title) {
      filename_prefix = title;
    } else {
      filename_prefix = 'Gauge Charts';
    }

    return filename_prefix + ' - ReforMeter';
  }

  filename = filename();

  function getSVG() {
    var svgElements = [],
        heightOfCharts = 0,
        xOffset = 0;

    var chartGroupHeight = $.makeArray(charts).reduce(
      function(biggestHeight, chart) {
        return Math.max(biggestHeight, chart.highchartsObject.chartHeight);
      },
      0
    );

    function convertChartToSvgGroupTag(chart, index) {
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

      heightOfCharts = parseInt(Math.max(heightOfCharts, highchartsObject.chartHeight));
      xOffset += parseInt(highchartsObject.chartWidth);

      return chartElement;
    }

    var chartElements = charts.map(convertChartToSvgGroupTag);

    var titleFontSize = 30;
    var titleTopPadding = 7;
    var subtitleFontSize = 18;

    // If there's a subtitle, make room for it
    var titleGroupHeight = subtitle ? titleFontSize * 2 + subtitleFontSize : titleFontSize * 2;

    var totalWidth = xOffset;
    var totalHeight = title ? heightOfCharts + titleGroupHeight : heightOfCharts;

    function backgroundRect() {
      return '<rect fill="white" x="0" y="0" width="' + totalWidth + '" height="' + totalHeight + '"></rect>';
    }

    function titleGroupElement(title, subtitle) {
      function surroundInTextElement(content) {
        return '<text style="font-family: sans-serif; background-color: white;" y="' + (titleFontSize + titleTopPadding) + '">' + content + '</text>';
      }

      var titleElement = '<tspan style="font-size: ' + titleFontSize + 'px;" text-anchor="middle" x="' + totalWidth/2 + '">' + title + '</tspan>';
      var subtitleElement = '';

      if (subtitle) {
        subtitleElement = '<tspan style="font-size: ' + subtitleFontSize + 'px; fill: #66666D;" text-anchor="middle" x="' + totalWidth/2 + '" dy="' + titleFontSize + 'px">' + subtitle + '</tspan>';
      }

      var titleElement = surroundInTextElement(
        titleElement + subtitleElement
      );

      return titleElement;
    }

    function groupedChartElements(chartElements) {
      var openingGTag;

      if (title) {
        openingGTag = '<g transform="translate(0, ' + titleGroupHeight + ')">';
      } else {
        openingGTag = '<g>';
      }

      return openingGTag + chartElements.join('') + '</g>';
    }

    svgElements.push(backgroundRect());

    if (typeof title === 'string') {
      svgElements.push(titleGroupElement(title, subtitle));
    }

    svgElements.push(groupedChartElements(chartElements));

    var chartGroupSVGContent = svgElements.join('');

    function surroundWithSVG(content) {

      return '<svg height="'+ totalHeight + '" width="' + totalWidth + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    return surroundWithSVG(chartGroupSVGContent);
  }

  chartGroup.getExportOptions = function(exportType) {
    if (!svg) svg = getSVG();

    return {
      filename: encodeURIComponent(filename),
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
