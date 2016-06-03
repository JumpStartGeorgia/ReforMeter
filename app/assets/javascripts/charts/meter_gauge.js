function highchartsMeterGaugeOptions(chartData) {
  return {

    chart: {
      type: 'gauge'
    },

    pane: {
      center: ['50%', '65%'],
      startAngle: -90,
      endAngle: 90,

      background: {
        backgroundColor: 'rgba(0, 0, 0, 0)',
        innerRadius: '40%',
        outerRadius: '100%',
        shape: 'arc'
      }

    },

    plotOptions: {
      solidgauge: {
        dataLabels: {
          y: 5,
          borderWidth: 0,
          useHTML: true
        }
      }
    },

    tooltip: {
      enabled: false
    },

    yAxis: {
      lineWidth: 0,
      minorTickInterval: null,
      tickPixelInterval: 400,
      tickWidth: 0,
      labels: {
        y: 16
      },
      min: 0,
      max: 10
    },

    credits: {
      enabled: false
    }
  };
}

function highchartsSmallMeterGaugeOptions(chartData) {
  var color = chartData.color;

  return {
    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'white',
          from: 0,
          to: 3.3,
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%'
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%'
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: 6.6,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
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
      text: chartData.title,
      y: 15
    },

    series: [{
      name: chartData.title,
      data: [chartData.score],
      dataLabels: {
        borderWidth: 0,
        y: 45,
        useHTML: true,
        formatter: function() {
          function inDiv(content) {
            return '<div style="text-align:center;">' + content + '</div>';
          }
          var score = '<span style="font-size:20px;color:black;">' + this.y + '</span>';

          if (chartData.icon) {
            return inDiv(score + chartData.icon);
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

function highchartsBigMeterGaugeOptions(chartData) {
  var color = chartData.color;

  return {
    title: {
      text: chartData.title,
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
          color: outputHighchartsColorString(color, '.6'),
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
          color: outputHighchartsColorString(color, '.8'),
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
          color: outputHighchartsColorString(color, '1'),
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
      name: chartData.title,
      data: [chartData.score],
      dataLabels: {
        borderWidth: 0,
        y: 70,
        useHTML: true,
        format: '<div style="text-align:center;"><span style="font-size:35px;color:black;">{y:.2f}</span>' + chartData.icon + '</div>'
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
