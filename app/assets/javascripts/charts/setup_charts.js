function quarterMeterGauges() {
  if (!gon.charts.quarters) {
    return [];
  } else {
    return gon.charts.quarters.map(function(quarter) {
      return smallMeterGauge(quarter, quarter.slug)
    });
  }
}

function setupCharts() {
  if (gon.charts) {
    $.merge(
      [
        bigMeterGauge(gon.charts.overall),
        smallMeterGauge(gon.charts.performance, 'performance'),
        smallMeterGauge(gon.charts.goals, 'goals'),
        smallMeterGauge(gon.charts.progress, 'progress'),
        expertHistoryTimeSeries(),
      ],
      quarterMeterGauges()
    ).forEach(function(item) {
      item.create();
    });
  }
}
