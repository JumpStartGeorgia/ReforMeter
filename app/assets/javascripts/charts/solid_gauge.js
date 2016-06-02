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
        format: '<div style="text-align:center;"><span style="font-size:15px;color:black;">{y}%</span><svg fill="#000000" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/><path d="M0 0h24v24H0z" fill="none"/></svg></div>'
      },
      tooltip: {
      	valueSuffix: '%'
      }
    }]
  };
}
