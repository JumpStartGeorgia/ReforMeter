function createPerformanceMeterGauge() {
  var $chart = $('.js-become-expert-performance-chart');
  var customOptions = {

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
      },
      pivot: {
        backgroundColor: 'white'
      },
      dial: {
        baseWidth: 20,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]

  };

  $chart.highcharts(Highcharts.merge(highchartsSmallMeterGauge(),
                    customOptions));
}

function createGoalsMeterGauge() {
  var $chart = $('.js-become-expert-goals-chart');
  var customOptions = {

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
      },
      pivot: {
        backgroundColor: 'white'
      },
      dial: {
        baseWidth: 20,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]

  };

  $chart.highcharts(Highcharts.merge(highchartsSmallMeterGauge(),
                    customOptions));
}

function createProgressMeterGauge() {
  var $chart = $('.js-become-expert-progress-chart');
  var customOptions = {

    title: {
      text: 'Progress',
      y: 15
    },

    series: [{
      name: 'Progress',
      data: [gon.charts.progress.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  gon.charts.progress.icon + '</div>'
      },
      pivot: {
        backgroundColor: 'white'
      },
      dial: {
        baseWidth: 20,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]

  };

  $chart.highcharts(Highcharts.merge(highchartsSmallMeterGauge(),
                    customOptions));
}


function setupExpertPage() {
  createExpertOverallMeterGauge();
  createPerformanceMeterGauge();
  createGoalsMeterGauge();
  createProgressMeterGauge();
}
