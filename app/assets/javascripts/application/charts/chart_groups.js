function initializeChartGroups(charts) {
  return gon.chartGroups.map(function(chartGroup) {
    var chartGroupCharts = chartGroup.chart_ids.map(function(chart_id) {
      return charts.filter(function() {
        return this.id === chart_id;
      })[0];
    });

    return initializeChartGroup(chartGroupCharts, chartGroup.id);
  });
}
