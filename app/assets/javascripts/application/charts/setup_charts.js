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

  postCreateChartImages($.makeArray(charts), 'image/png');

  var chartGroups = gon.chartGroups.map(function(chartGroup) {
    var chartGroupCharts = chartGroup.chart_ids.map(function(chart_id) {
      return charts.filter(function() {
        return this.id === chart_id;
      })[0];
    });

    return initializeChartGroup(chartGroupCharts, chartGroup.id)
  });

  setupExportChartGroupButtons(charts);

  return charts;
}
