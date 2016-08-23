function highchartsHomepageMeterGaugeOptions(chartData) {
  var mainContentPadding = 30;

  // Size is responsive to the width of the chart's container, with a max of 400
  function size() {
    if (chartData.size) return chartData.size;

    var defaultSize = 400;

    if (chartData.responsiveTo) {
      var mainContentWidth = $(chartData.responsiveTo).width() - (mainContentPadding * 2);

      if (mainContentWidth < defaultSize) {
        return mainContentWidth;
      }
    }

    return defaultSize;
  }

  size = size();

  var color = chartData.color;

  var helpers = meterGaugeHelpers(size);
  var plotBandLabels = helpers.plotBandLabels();

  var options = {

    chart: {
      width: helpers.chartWidth,
      height: helpers.chartHeight
    },

    exporting: {
      chartOptions: {
        chart: {
          backgroundColor: '#5a5a90'
        }
      }
    },

    title: {
      text: chartData.title,
      y: 15
    },

    pane: {
      size: helpers.paneSize
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
        y: helpers.textPosition(.33),
        useHTML: true,
        formatter: function() {
          return highchartsGaugeLabel(
            chartData,
            this,
            helpers.textSize(4),
            {
              color: 'white',
              maxIconWidth: '55px'
            }
          );
        }
      },
      pivot: {
        backgroundColor: '#5e588e'
      },
      dial: {
        baseWidth: helpers.paneSize/10,
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
