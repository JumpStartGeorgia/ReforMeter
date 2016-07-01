function initializeHighchart($container) {
  var highchart = {}
  var chartType = $container.data('chart-type');
  var containerChartID = $container.data('id')

  function chartData() {
    return gon.charts.filter(function(chartData) {
      return chartData.id === containerChartID;
    })[0];
  }

  var highchartData = chartData();

  if (!highchartData) {
    throw new Error('No data for chart ' + containerChartID);
  }

  highchart.create = function() {
    $container.highcharts(
      Highcharts.merge(
        highchartsOptions(chartType, highchartData)
      )
    );
  };

  return highchart;
}

function setupCharts() {
  var $charts = $('.js-become-highchart');

  if ($charts.length === 0) {
    return null;
  }

  setupDefaultOptions();

  var charts = $charts.map(function() {
    return initializeHighchart($(this));
  });

  $(charts).each(function() {
    this.create();
  });
}
