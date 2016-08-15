function highchartsBigMeterGaugeOptions(chartData) {
  // See meter gauge helpers file for documentation on size variable
  var size = 200;
  var color = chartData.color;

  var helpers = meterGaugeHelpers(size);
  var plotBandLabels = helpers.plotBandLabels(['Poor', 'Fair', 'Good']);

  function gaugeLabel(dataPoint, isExport) {
    return highchartsGaugeLabel(
      chartData,
      dataPoint,
      helpers.textSize(3.5),
      {
        changeIcon: !isExport
      }
    );
  }

  var options = {

    chart: {
      width: helpers.chartWidth,
      height: helpers.chartHeight,
      plotBorderColor: 'transparent'
    },

    exporting: {
      chartOptions: {
        plotOptions: {
          gauge: {
            dataLabels: {
              formatter: function() {
                return gaugeLabel(this, true);
              }
            }
          }
        }
      }
    },

    title: {
      text: chartData.title,
      y: 15
    },

    pane: {
      background: {
        borderWidth: 0
      },
      size: helpers.paneSize
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
          label: plotBandLabels.behind(chartData)
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels.onTrack(
            chartData,
            {
              y: 30
            }
          )
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 6.6,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels.ahead(
            chartData,
            {
              y: localeIs('ka') ? 35 : 45
            }
          )
        }
      ]
    },

    plotOptions: {
      gauge: {
        dataLabels: {
          borderWidth: 0,
          y: 70,
          useHTML: true,
          formatter: function() {
            return gaugeLabel(this, false);
          }
        },
        pivot: {
          backgroundColor: 'white'
        },
        dial: {
          baseWidth: helpers.paneSize/10,
          backgroundColor: 'rgba(0, 0, 0, 0.7)',
          baseLength: 0,
          radius: '60%',
          rearLength: '10%'
        }
      }
    },

    series: [{
      name: chartData.title,
      data: [chartData.score]
    }]

  };

  return Highcharts.merge(
    highchartsMeterGaugeOptions(chartData),
    options
  );

}
