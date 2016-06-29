function highchartsSmallSolidGaugeOptions(chartData) {
  function getHeight() {
    if (chartData.title) {
      return '175';
    } else {
      return '100';
    }
  }

  return {
  	chart: {
    	type: 'solidgauge',
      height: getHeight()
    },

		title: {
      style: {
        fontSize: '16px'
      },
    	text: chartData.title,
      verticalAlign: 'top',
    },

    pane: {
      center: ['50%', '70%'],
      size: '100',
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
        y: 16,
        enabled: false
      },
    	stops: [
      	[0, outputHighchartsColorString(chartData.color, '1', '#FFF')]
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
          return highchartsGaugeLabel(chartData, this, '20', { unit: '%' });
        }
      },
      tooltip: {
      	valueSuffix: '%'
      }
    }]
  };
}
