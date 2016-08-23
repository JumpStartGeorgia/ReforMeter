function initializeChartGroup(charts) {
  var chartGroup = {};

  chartGroup.getSVG = function() {
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
          height: chartGroupHeight,
          style: {
            fontFamily: 'sans-serif',
            fontSize: '9.5px'
          },
          width: highchartsObject.chartWidth
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
      xOffset += highchartsObject.chartWidth;

      svgArr.push(svg);
    });

    function surroundWithSVG(content) {
      return '<svg height="'+ height + '" width="' + xOffset + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    var svgObj = surroundWithSVG(svgArr.join(''));

    return svgObj;
  }

  return chartGroup;
}

function initializeExportChartGroupButton($exportButton, charts) {
  var exportType = $exportButton.data('export-type'),
      allowedTypes = ['image/png', 'image/jpeg', 'application/pdf', 'image/svg+xml'];

  if (!allowedTypes.includes(exportType)) {
    throw new Error('Export button has not allowed type');
  }

  var chartGroup = initializeChartGroup(charts);

  function multipleChartExportOptions() {
    return {
      filename: 'Gauge_Charts_ReforMeter',
      type: exportType,
      svg: chartGroup.getSVG()
    };
  }

  function postExportRequest() {
    var exportOptions;

    if (charts.length === 1) {

      exportOptions = charts[0].getExportOptions(exportType);

    } else {

      exportOptions = multipleChartExportOptions();

    }

    Highcharts.post(
      Highcharts.merge(Highcharts.getOptions().exporting).url,
      exportOptions
    );
  };

  return {
    setup: function() {
      postExportRequest();
      $exportButton.parents('.js-act-as-chart-export-menu').addClass('is-hidden');
    }
  }
}
