function chartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

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
    }
  };
}

function highchartsSmallMeterGauge() {
  var small_meter_gauge = {
    pane: {
      size: '100'
    },

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
    }
  }

  return Highcharts.merge(Highcharts.merge(highchartsMeterGauge(), small_meter_gauge));
}
