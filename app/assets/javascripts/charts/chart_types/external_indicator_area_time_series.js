function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.color;
  var max = chartData.max;

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80,
      type: 'areaspline'
    },
    exporting: {
      enabled: true
    },
    legend: {
      enabled: false
    },
    plotOptions: {
      areaspline: {
        color: '#f7d95c',
        fillColor: {
          linearGradient: {
            x1: 0,
            y1: 0,
            x2: 0,
            y2: 1
          },
          stops: [
            [0, '#faa24f'],
            [1, '#f7d95c']
          ]
        },
        lineWidth: 0,
        marker: {
          enabled: false
        }
      }
    },
    series: chartData.series,
    title: {
      text: chartData.title
    },
    tooltip: {
      backgroundColor: '#455357',
      formatter: function() {
        indexBoxes.update(this);

        return Math.round(this.y);
      },
      style: {
        color: 'white',
        fontSize: '2rem'
      }
    },
    yAxis: {
      plotBands: ratingTimeSeriesYAxisPlotBands(
        [
          {
            from: max * 0,
            to: max * .25,
            label: {
              text: 'Fail',
              style: {
                color: outputHighchartsColorString(color, '.4')
              }
            }
          }, {
            from: max * .25,
            to: max * .5,
            label: {
              text: 'Poor',
              style: {
                color: outputHighchartsColorString(color, '.6')
              }
            }
          }, {
            from: max * .5,
            to: max * .75,
            label: {
              text: 'Fair',
              style: {
                color: outputHighchartsColorString(color, '.8')
              }
            }
          }, {
            from: max * .75,
            to: max,
            label: {
              text: 'Good',
              style: {
                color: outputHighchartsColorString(color, '1')
              }
            }
          }
        ]
      )
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
