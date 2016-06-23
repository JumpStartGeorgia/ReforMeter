function highchartsHomepageMeterGaugeOptions(chartData) {
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
          borderColor: 'transparent',
          from: 0,
          to: 3.3,
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
            text: 'Behind',
            rotation: -60,
            x: 55,
            y: 60,
            style: {
              fontSize: '18px',
              color: 'white'
            }
          }
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
            text: 'On Track',
            x: 88,
            y: 20,
            style: {
              fontSize: '18px',
              color: 'white'
            }
          }
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 6.6,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: {
            text: 'Ahead',
            rotation: 60,
            x: 173,
            y: 35,
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
        formatter: function() {
          return highchartsGaugeLabel(chartData, this, '35', { color: 'white' });
        }
      },
      pivot: {
        backgroundColor: 'rgb(0, 0, 0)'
      },
      dial: {
        baseWidth: 20,
        backgroundColor: 'rgb(255, 255, 255)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]

  };
}
