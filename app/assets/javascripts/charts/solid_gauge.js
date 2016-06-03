function highchartsBigSolidGaugeOptions(chartData) {
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
        [0, outputHighchartsColorString(chartData.color, '1')]
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
        formatter: function() {
          return highchartsGaugeLabel(chartData, this, '35', '%');
        }
      },
      tooltip: {
        valueSuffix: '%'
      }
    }]
  };
}

function highchartsSmallSolidGaugeOptions(chartData) {
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
      size: '80%',
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
      	[0, '#FFF']
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
        formatter: function() {
          return highchartsGaugeLabel(chartData, this, '14', '%');
        }
      },
      tooltip: {
      	valueSuffix: '%'
      }
    }]
  };
}
