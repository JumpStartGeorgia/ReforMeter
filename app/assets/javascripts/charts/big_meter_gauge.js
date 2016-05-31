function bigMeterGauge(chart_data) {
  var chart = {};
  var $chart = $('.js-become-big-meter-gauge');

  function customOptions() {
    return {

      title: {
        text: chart_data.title,
        y: 15
      },

      pane: {
        size: '200'
      },

      yAxis: {
        plotBands: [
          {
            borderWidth: 2,
            borderColor: 'white',
            from: 0,
            to: 3.3,
            color: '#5AD7F9',
            innerRadius: '40%',
            outerRadius: '100%',
            label: {
              text: 'Poor',
              rotation: -60,
              x: 60,
              y: 55,
              style: {
                fontSize: '18px',
                color: 'white'
              }
            }
          },{
            borderWidth: 2,
            borderColor: 'white',
            from: 3.3,
            to: 6.6,
            color: '#2DB9EA',
            innerRadius: '40%',
            outerRadius: '100%',
            label: {
              text: 'Normal',
              x: 98,
              y: 30,
              style: {
                fontSize: '18px',
                color: 'white'
              }
            }
          },{
            borderWidth: 2,
            borderColor: 'white',
            from: 6.6,
            to: 10,
            color: '#1599D6',
            innerRadius: '40%',
            outerRadius: '100%',
            label: {
              text: 'Good',
              rotation: 60,
              x: 170,
              y: 45,
              style: {
                fontSize: '18px',
                color: 'white'
              }
            }
          }
        ]
      },

      series: [{
        name: chart_data.title,
        data: [chart_data.score],
        dataLabels: {
          borderWidth: 0,
          y: 70,
          useHTML: true,
          format: '<div style="text-align:center;"><span style="font-size:35px;color:black;">{y:.2f}</span>' + chart_data.icon + '</div>'
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
  }

  chart.create = function() {
    if (chart_data && ($chart.length > 0)) {
      $chart.highcharts(Highcharts.merge(highchartsMeterGauge(), customOptions()));
    }
  };

  return chart;
}
