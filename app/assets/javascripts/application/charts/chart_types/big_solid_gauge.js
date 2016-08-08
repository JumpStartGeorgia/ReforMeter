function highchartsBigSolidGaugeOptions(chartData) {
  function gaugeLabel(dataPoint, isExport) {
    return highchartsGaugeLabel(
      chartData,
      dataPoint,
      '3.5em',
      {
        unit: '%',
        changeIcon: !isExport
      }
    );
  }

  return {
    chart: {
      type: 'solidgauge'
    },

    exporting: {
      chartOptions: {
        plotOptions: {
          solidgauge: {
            dataLabels: {
              formatter: function() {
                return gaugeLabel(this, true);
              }
            }
          }
        }
      }
    },

    title: {
      text: chartData.title,
      y: 15
    },

    pane: {
      center: ['50%', '68%'],
      size: '200',
      startAngle: -90,
      endAngle: 90,
      background: {
        backgroundColor: '#EEE',
        innerRadius: '0%',
        outerRadius: '100%',
        shape: 'arc',
        borderWidth: 1.5,
        borderColor: 'white'
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
        [0, outputHighchartsColorString(chartData.color, '1')]
      ]
    },

    plotOptions: {
      solidgauge: {
        innerRadius: '0%',
        dataLabels: {
          borderWidth: 0,
          y: 70,
          useHTML: true,
          formatter: function() {
            return gaugeLabel(this, false);
          }
        },
        tooltip: {
          valueSuffix: '%'
        }
      }
    },

    series: [{
      name: chartData.title,
      data: [chartData.score]
    }]
  };
}
