function createPerformanceMeterGauge() {
  var performance_meter_gauge = {

    title: {
      text: 'Performance',
      y: 15
    },

    series: [{
      name: 'Performance',
      data: [gon.charts.performance.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  gon.charts.performance.icon + '</div>'
      }
    }]

  };

  $('.js-become-performance-overall-chart').highcharts(Highcharts.merge(highchartsSmallMeterGauge(), performance_meter_gauge));

}

function createGoalsMeterGauge() {
  var goals_meter_gauge = {

    title: {
      text: 'Goals',
      y: 15
    },

    series: [{
      name: 'Goals',
      data: [gon.charts.goals.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  gon.charts.goals.icon + '</div>'
      }
    }]

  };

  $('.js-become-goals-overall-chart').highcharts(Highcharts.merge(highchartsSmallMeterGauge(), goals_meter_gauge));
}

function setupExpertPage() {
  createExpertOverallMeterGauge();
  createPerformanceMeterGauge();
  createGoalsMeterGauge();
}
