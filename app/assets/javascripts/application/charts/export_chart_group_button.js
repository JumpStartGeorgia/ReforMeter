function initializeExportChartGroupButton($exportButton, charts) {
  var exportType = $exportButton.data('export-type'),
      allowedTypes = ['image/png', 'image/jpeg', 'application/pdf', 'image/svg+xml'];

  if (!allowedTypes.includes(exportType)) {
    throw new Error('Export button has not allowed type');
  }

  function getChartGroupSVG() {
    var svgArr = [],
        height = 0,
        xOffset = 0;

    var chartGroupHeight = $.makeArray(charts).reduce(
      function(biggestHeight, chart) {
        return Math.max(biggestHeight, chart.highchartsObject.chartHeight);
      },
      0
    );
    
    $.each(charts, function(i, chart) {
      var highchartsObject = chart.highchartsObject;
      
      var svg = highchartsObject.getSVG(
        {
          chart: {
            backgroundColor: 'white',
            height: chartGroupHeight,
            style: {
              fontSize: '9.5px'
            },
            width: highchartsObject.chartWidth
          }
        }
      );

      svg = svg.replace('<svg', '<g transform="translate(' + xOffset + ',0)" ');
      svg = svg.replace('</svg>', '</g>');

      height = Math.max(height, highchartsObject.chartHeight);
      xOffset += highchartsObject.chartWidth;

      svgArr.push(svg);
    });

    function surroundWithSVG(content) {
      return '<svg height="'+ height + '" width="' + xOffset + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
    }

    var svgObj = surroundWithSVG(
      svgArr.join('')
    );

    return svgObj;
  }

  function exportCharts(options) {
    options = Highcharts.merge(Highcharts.getOptions().exporting, options);

    Highcharts.post(options.url, {
    	filename: options.filename || 'chart',
        type: exportType,
        width: options.width,
        svg: getChartGroupSVG()
    });
  };

  $exportButton.click(
    function() {
      exportCharts();
    }
  );
}
