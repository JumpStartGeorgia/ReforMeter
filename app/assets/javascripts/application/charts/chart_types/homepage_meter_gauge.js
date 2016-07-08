function highchartsHomepageMeterGaugeOptions(chartData) {
  // See meter gauge helpers file for documentation on size variable
  var size = 200;
  var color = chartData.color;

  var helpers = meterGaugeHelpers(size);
  var plotBandLabels = helpers.plotBandLabels();

  var options = {

    chart: {
      width: size * 1.25,
      height: size * 1.1,
    },
    title: {
      text: chartData.title,
      y: 15
    },

    pane: {
      size: size
    },

    yAxis: {
      labels: {
        enabled: false
      },
      plotBands: [
        {
          borderWidth: 0,
          from: 0,
          to: 3.2,
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels.behind(chartData)
        },{
          borderWidth: 0,
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels.onTrack(chartData)
        },{
          borderWidth: 0,
          from: 6.7,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels.ahead(chartData)
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
          return helpers.dataLabel(
            chartData,
            this,
            helpers.textSize(3.5),
            {
              color: 'white'
            }
          );
        }
      },
      pivot: {
        backgroundColor: '#5e588e'
      },
      dial: {
        baseWidth: size/10,
        backgroundColor: 'rgb(255, 255, 255)',
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
