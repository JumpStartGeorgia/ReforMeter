function initializeExportChartGroupButton($exportButton, charts) {
  function getChartGroupSVG() {
    var svgArr = [],
        top = 0,
        width = 0;

    $.each(charts, function(i, chart) {
      var svg = chart.getSVG(
        {
          chart: {
            height: chart.chartHeight,
            width: chart.chartWidth
          }
        }
      );

      svg = svg.replace('<svg', '<g transform="translate(0,' + top + ')" ');
      svg = svg.replace('</svg>', '</g>');

      top += chart.chartHeight;
      width = Math.max(width, chart.chartWidth);

      svgArr.push(svg);
    });

    function surroundWithSVG(content) {
      return '<svg height="'+ top +'" width="' + width + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + content + '</svg>';
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
        type: options.type,
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
