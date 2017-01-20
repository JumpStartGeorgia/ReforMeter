function highchartsSmallMeterGaugeOptions(chartData) {
  var color = chartData.color;
  var size = 100;

  if (chartData.responsiveTo) {
    if ($(chartData.responsiveTo).width() >= 450) {
      size = 150;
    }
  }

  var helpers = meterGaugeHelpers(size, {}, chartData);
  var min = helpers.min;
  var max = helpers.max;

  function plotBandLabels() {
    if (typeof chartData.plotBandLabelTexts === 'undefined') return undefined;
    if (size < 150) return undefined;

    return helpers.plotBandLabels(chartData.plotBandLabelTexts);
  }

  plotBandLabels = plotBandLabels();

  function gaugeLabel(dataPoint, isExport) {
    return highchartsGaugeLabel(
      chartData,
      dataPoint,
      '2em',
      {
        changeIcon: !isExport,
        secondLineText: helpers.plotBandLabelForScore(
          chartData.score,
          plotBandLabels ? null : chartData.plotBandLabelTexts
        )
      }
    );
  }

  var options = {

    chart: {
      height: chartData.title ? size + 50 + '' : size + 15 + '',
      width: helpers.chartWidth
    },

    exporting: {
      chartOptions: {
        pane: {
          center: ['50%', '72%']
        },
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

    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'white',
          from: helpers.plotBandRanges[0],
          to: helpers.plotBandRanges[1],
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels ? plotBandLabels.behind(chartData) : false
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: helpers.plotBandRanges[1],
          to: helpers.plotBandRanges[2],
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels ? plotBandLabels.onTrack(chartData) : false
        },{
          borderWidth: 2,
          borderColor: 'white',
          from: helpers.plotBandRanges[2],
          to: helpers.plotBandRanges[3],
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: plotBandLabels ? plotBandLabels.ahead(chartData) : false
        }
      ],
      labels: {
        enabled: false
      },
      min: helpers.min,
      max: helpers.max
    },

    pane: {
      size: helpers.paneSize,
      center: ['50%', '58%']
    },

    plotOptions: {
      gauge: {
        dataLabels: {
          borderWidth: 0,
          y: 50,
          useHTML: true,
          formatter: function() {
            return gaugeLabel(this, false);
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
      }
    },

    title: {
      style: {
        fontSize: '1.4em'
      },
      text: chartData.title,
      verticalAlign: 'top',
      widthAdjust: 0
    },

    series: [{
      name: chartData.title,
      data: [chartData.use_decimals ? Number(Math.round(chartData.score+'e2')+'e-2') : Math.round(chartData.score)]
    }]
  };

  return Highcharts.merge(
    highchartsMeterGaugeOptions(chartData),
    options
  );
}
