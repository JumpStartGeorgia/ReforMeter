function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.colorHash;
  var max = chartData.max;
  var spacingLeft = localeIs('ka') ? 120 : 80;

  function plotBands(plotBands) {
    $(plotBands).each(
      function() {
        this.label.x = localeIs('ka') ? -140 : -100;
        this.label.verticalAlign = 'middle';
        this.label.style.fontSize = localeIs('ka') ? '1.4em' : '1.6em';
        this.label.style.fontWeight = '600';
      }
    );

    return plotBands;
  }

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      marginTop: externalIndicatorChart.marginTop,
      type: 'areaspline'
    },
    exporting: {
      enabled: true,
      chartOptions: {
        title: externalIndicatorChart.title(
          chartData.title,
          {
            titleOptions: {
              x: -1 * spacingLeft + 10
            }
          }
        )
      }
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
        x: -1 * spacingLeft + 10
      }
    ),
    title: externalIndicatorChart.title(
      chartData.title,
      {
        description: chartData.description,
        titleOptions: {
          x: -1 * spacingLeft + 10
        }
      }
    ),
    tooltip: {
      backgroundColor: '#f3f3f4',
      formatter: function() {
        indexBoxes.update(this);

        return externalIndicatorChart.tooltipFormatter(this.points[0]);
      },
      style: {
        fontSize: '2em',
        fontWeight: '600'
      }
    },
    yAxis: {
      plotBands: plotBands(
        [
          {
            from: max * 0,
            to: max * .25,
            label: {
              text: chartData.translations.fail,
              style: {
                color: outputHighchartsColorString(color, '.4')
              }
            }
          }, {
            from: max * .25,
            to: max * .5,
            label: {
              text: chartData.translations.poor,
              style: {
                color: outputHighchartsColorString(color, '.6')
              }
            }
          }, {
            from: max * .5,
            to: max * .75,
            label: {
              text: chartData.translations.fair,
              style: {
                color: outputHighchartsColorString(color, '.8')
              }
            }
          }, {
            from: max * .75,
            to: max,
            label: {
              text: chartData.translations.good,
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
