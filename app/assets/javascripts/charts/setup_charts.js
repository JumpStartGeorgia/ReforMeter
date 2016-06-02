function setupHighchart($container) {
  var highchart = {}
  var chartType = $container.data('chart-type');

  function chartData() {
    return gon.charts.filter(function(chartData) {
      return chartData.id === $container.data('id');
    })[0];
  }

  highchart.create = function() {
    $container.highcharts(Highcharts.merge(highchartsOptions(chartType, chartData())));
  };

  return highchart;
}

function setupCharts() {
  $('.js-become-highchart').each(function() {
    setupHighchart($(this)).create();;
  });
}
