function highchartsSmallMeterGaugeOptions(chartData) {
  var color = chartData.color;

  return {
    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'white',
          from: 0,
          to: 3.3,
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%'
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%'
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: 6.6,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%'
        }
      ],
      labels: {
        enabled: false
      }
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
          return highchartsGaugeLabel(chartData, this, '20');
        }
      },
      pivot: {
        backgroundColor: 'white',
        radius: 4
      },
      dial: {
        baseWidth: 15,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]
  };
}
