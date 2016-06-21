function initializeExportChartGroupButton($exportButton, charts) {
  function getChartGroupSVG() {
    var svgArr = [],
        top = 0,
        width = 0;

    $.each(charts, function(i, chart) {
      var svg = chart.getSVG(
        {
          chart: {
            width: chart.chartWidth,
            height: chart.chartHeight
          }
        }
      );

      svg = svg.replace('<svg', '<g transform="translate(0,' + top + ')" ');
      svg = svg.replace('</svg>', '</g>');

      top += chart.chartHeight;
      width = Math.max(width, chart.chartWidth);

      svgArr.push(svg);
    });

    var svgObj = '<svg height="'+ top +'" width="' + width + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + svgArr.join('') + '</svg>';

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
