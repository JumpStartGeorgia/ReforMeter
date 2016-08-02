function highchartsSmallMeterGaugeOptions(chartData) {
  var color = chartData.color;
  
  var helpers = meterGaugeHelpers(100);

  var options = {
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
      style: {
        fontSize: '1.6em'
      },
      text: chartData.title,
      y: 15
    },

    series: [{
      name: chartData.title,
      data: [chartData.score],
      dataLabels: {
        borderWidth: 0,
        y: 50,
        useHTML: true,
        formatter: function() {
          return highchartsGaugeLabel(
            chartData, 
            this, 
            '2em', 
            {
              secondLineText: helpers.plotBandLabelForScore(chartData.score)
            }
          );
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

  return Highcharts.merge(
    highchartsMeterGaugeOptions(chartData),
    options
  );
}
