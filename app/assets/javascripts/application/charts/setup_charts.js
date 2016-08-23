function setupCharts() {
  var $charts = $('.js-become-highchart');

  if ($charts.length === 0) {
    return null;
  }

  setupDefaultOptions();

  var charts = $charts.map(function() {
    var $container = $(this);
    var containerChartID = $container.data('id');

    function chartData() {
      return gon.charts.filter(function(chartData) {
        return chartData.id === containerChartID;
      })[0];
    }

    var highchartData = chartData();

    if (!highchartData) {
      return undefined;
    }

    return initializeHighchart($container, highchartData);
  }).filter(function() {
    return typeof this !== 'undefined';
  });

  $(charts).each(function() {
    this.create();
  });

  var chartGroups = initializeChartGroups(charts);

  postCreateChartImages($.makeArray(charts), 'image/png');
  setupExportChartGroupButtons(charts);

  return charts;
}
