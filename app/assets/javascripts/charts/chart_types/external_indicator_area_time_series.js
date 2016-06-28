function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.colorHash;
  var max = chartData.max;
  var spacingLeft = 80;

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      marginTop: externalIndicatorChart.marginTop,
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
    subtitle: externalIndicatorChart.subtitle(
      chartData.subtitle,
      {
        x: -1 * spacingLeft
      }
    ),
    title: externalIndicatorChart.title(
      chartData.title,
      {
        x: -1 * spacingLeft
      }
    ),
    tooltip: {
      backgroundColor: '#f3f3f4',
      formatter: function() {
        indexBoxes.update(this);

        return externalIndicatorChart.tooltipFormatter(this.points[0]);
      },
      style: {
        fontSize: '2rem',
        fontWeight: '600'
      }
    },
    yAxis: {
      plotBands: customTimeSeriesPlotBands(
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
      ),
      title: {
        text: chartData.unitLabel
      }
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
