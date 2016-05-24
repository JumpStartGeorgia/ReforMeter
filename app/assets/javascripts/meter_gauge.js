function highchartsMeterGauge() {
  return {

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
    },

    series: [{
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
