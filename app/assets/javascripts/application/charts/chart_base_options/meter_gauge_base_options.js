function highchartsMeterGaugeOptions(chartData) {
  return {

    chart: {
      type: 'gauge',
      backgroundColor: 'transparent'
    },

    pane: {
      center: ['50%', '65%'],
      startAngle: -90,
      endAngle: 90,

      background: {
        backgroundColor: 'rgba(0, 0, 0, 0)',
        innerRadius: '40%',
        outerRadius: '100%',
        shape: 'arc',
        borderWidth: 0
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
