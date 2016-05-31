function setupCharts() {
  if (gon.charts) {
    [
      bigMeterGauge(gon.charts.overall),
      smallMeterGauge(gon.charts.performance, 'performance'),
      smallMeterGauge(gon.charts.goals, 'goals'),
      smallMeterGauge(gon.charts.progress, 'progress')
    ].forEach(function(item) {
      item.create();
    });
  }
}
