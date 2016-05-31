function smallMeterGauge(chart_data, dataType) {
  var chart = {};
  var $chart = $('.js-become-small-meter-gauge[data-type="' + dataType + '"]');

  function customOptions() {
    return {
      yAxis: {
        plotBands: [
          {
            borderWidth: 2,
            borderColor: 'white',
            from: 0,
            to: 3.3,
            color: chartColors()[2],
            innerRadius: '40%',
            outerRadius: '100%'
          },{
            borderWidth: 2,
            borderColor: 'white',
            from: 3.3,
            to: 6.6,
            color: chartColors()[1],
            innerRadius: '40%',
            outerRadius: '100%'
          },{
            borderWidth: 2,
            borderColor: 'white',
            from: 6.6,
            to: 10,
            color: chartColors()[0],
            innerRadius: '40%',
            outerRadius: '100%'
          }
        ]
      },

      chart: {
        height: '125',
        width: '100'
      },

      pane: {
        size: '100'
      },

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
          formatter: function() {
            function inDiv(content) {
              return '<div style="text-align:center;">' + content + '</div>';
            }
            var score = '<span style="font-size:20px;color:black;">' + this.y + '</span>';

            if (chart_data.icon) {
              return inDiv(score + chart_data.icon);
            } else {
              return inDiv(score);
            }
          }
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
      $chart.highcharts(Highcharts.merge(highchartsMeterGauge(),
                        customOptions()));
    }
  }

  return chart;
}
