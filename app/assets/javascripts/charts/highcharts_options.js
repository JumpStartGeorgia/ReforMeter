function chartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

function highchartsOptions(chartType, chartData) {
  var highchartsMeterGauge = {

    chart: {
      type: 'gauge'
    },

    pane: {
      center: ['50%', '65%'],
      startAngle: -90,
      endAngle: 90,

      background: {
        backgroundColor: '#EEE',
        innerRadius: '60%',
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

  if (chartType === 'history-time-series') {
    return expertHistoryTimeSeriesOptions(chartData);
  } else if (chartType === 'small-meter-gauge') {
    return Highcharts.merge(
      highchartsMeterGauge,
      {
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
      });
  } else if (chartType === 'big-meter-gauge') {
    return Highcharts.merge(highchartsMeterGauge, {

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

    });
  } else if (chartType === 'big-solid-gauge') {
    return {
      chart: {
        type: 'solidgauge'
      },

      title: {
        text: chartData.title,
        y: 40
      },

      pane: {
        center: ['50%', '80%'],
        size: '120%',
        startAngle: -90,
        endAngle: 90,
        background: {
          backgroundColor: '#EEE',
          innerRadius: '0%',
          outerRadius: '100%',
          shape: 'arc'
        }
      },

      tooltip: {
        enabled: false
      },

      credits: {
        enabled: false
      },

      yAxis: {
        min: 0,
        max: 100,
        tickWidth: 0,
        minorTickInterval: null,
        tickPixelInterval: 99999,
        lineWidth: 0,
        labels: {
          y: 16
        },
        stops: [
          [0, '#7668DD']
        ]
      },

      plotOptions: {
        solidgauge: {
          innerRadius: '0%',
        }
      },

      series: [{
        name: chartData.title,
        data: [chartData.score],
        dataLabels: {
          borderWidth: 0,
          y: 45,
          useHTML: true,
          format: '<div style="text-align:center;"><span style="font-size:25px;color:black;">{y}%</span><svg fill="#000000" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/><path d="M0 0h24v24H0z" fill="none"/></svg></div>'
        },
        tooltip: {
          valueSuffix: '%'
        }
      }]
    };
  }
}
