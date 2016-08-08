function highchartsSmallSolidGaugeOptions(chartData) {

  function scoreLabelText() {
    switch (chartData.change) {

      case 0: {
        return gon.translations.government.rating.middle;
      }

      case 1: {
        return gon.translations.government.rating.rising;
      }

    }

    return '';
  }

  scoreLabelText = scoreLabelText();

  return {
  	chart: {
    	type: 'solidgauge',
      height: chartData.title ? '195' : '135'
    },

    exporting: {
      chartOptions: {
        plotOptions: {
        	solidgauge: {
            dataLabels: {
              formatter: function() {
                return highchartsGaugeLabel(
                  chartData,
                  this,
                  '2em',
                  {
                    unit: '%',
                    changeIcon: false,
                    secondLineText: scoreLabelText
                  }
                );
              }
            }
          }
        }
      }
    },

		title: {
      style: {
        fontSize: '1.35em'
      },
    	text: chartData.title,
      verticalAlign: 'top',
      widthAdjust: 0
    },

    pane: {
      center: ['50%', '65%'],
      size: '100',
      startAngle: -90,
      endAngle: 90,
      background: {
        backgroundColor: '#EEE',
        innerRadius: '0%',
        outerRadius: '100%',
        shape: 'arc',
        borderWidth: 0
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
        dataLabels: {
          borderWidth: 0,
          y: scoreLabelText === '' ? 38 : 50,
          useHTML: true,
          formatter: function() {
            return highchartsGaugeLabel(
              chartData,
              this,
              '2em',
              {
                unit: '%',
                secondLineText: scoreLabelText
              }
            );
          },
          tooltip: {
          	valueSuffix: '%'
          }
        }
      }
    },

    series: [{
			name: chartData.title,
      data: [chartData.score]
    }]
  };
}
