function createPerformanceMeterGauge() {
  var chart_data = gon.charts.performance;
  var $chart = $('.js-become-expert-performance-chart');
  var customOptions = {

    title: {
      text: chart_data.title,
      y: 15
    },

    series: [{
      name: chart_data.title,
      data: [chart_data.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  chart_data.icon + '</div>'
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
  var chart_data = gon.charts.goals;
  var $chart = $('.js-become-expert-goals-chart');
  var customOptions = {

    title: {
      text: chart_data.title,
      y: 15
    },

    series: [{
      name: chart_data.title,
      data: [chart_data.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  chart_data.icon + '</div>'
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
  var chart_data = gon.charts.progress;
  var $chart = $('.js-become-expert-progress-chart');
  var customOptions = {

    title: {
      text: chart_data.title,
      y: 15
    },

    series: [{
      name: chart_data.title,
      data: [chart_data.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:20px;color:black;">{y:.2f}</span>' +  chart_data.icon + '</div>'
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
  expertOverallMeterGauge().create();
  createPerformanceMeterGauge();
  createGoalsMeterGauge();
  createProgressMeterGauge();
}
