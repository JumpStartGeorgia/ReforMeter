function historyTimeSeriesOptions(chartData) {
  var color = chartData.color;

  function areasplineFillColors() {
    var topColor;
    var bottomColor;

    if (color) {
      bottomColor = outputHighchartsColorString(color, '.6');
      topColor = outputHighchartsColorString(color, '1');
    } else {
      bottomColor = defaultChartColors()[2];
      topColor = defaultChartColors()[0];
    }

    return [
      [0, topColor],
      [1, bottomColor]
    ];
  }

  function xAxisCrosshair() {
    if (chartData.series.length > 1) {
      return {
        color: 'black',
        dashStyle: 'solid',
        width: 1,
        zIndex: 99
      };
    } else {
      return false;
    }
  }

  return {
    chart: {
      zoomType: 'x',
      type: 'spline',
      height: null,
      width: null
    },
    title: {
      text: null
    },
    colors: ['#000'],
    xAxis: {
      crosshair: xAxisCrosshair(),
      // Using labels instead of categories to make x axis start on tick
      // Source: http://stackoverflow.com/questions/18593883/highcharts-remove-gap-between-start-of-xaxis-and-first-value
      labels: {
        enabled: true,
        formatter: function () {
            return chartData.categories[this.value];
        }
      },
      tickmarkPlacement: 'on',
      type: 'datetime'
    },
    legend: {
      align: 'right',
      symbolWidth: 40
    },
    yAxis: {
      minorGridLineDashStyle: 'dot',
      gridLineDashStyle: 'dot',
      title: {
        text: null
      }
    },
    plotOptions: {
      areaspline: {
        color: outputHighchartsColorString(color, '1'),
        fillColor: {
          linearGradient: {
            x1: 0,
            y1: 0,
            x2: 0,
            y2: 1
          },
          stops: areasplineFillColors()
        },
        lineWidth: 0,
        marker: {
          enabled: false
        }
      },
      spline: {
        marker: {
          enabled: false
        }
      }
    },
    series: chartData.series,
    tooltip: {
      backgroundColor: 'white',
      borderWidth: 0,
      formatter: function() {
        return highchartTimeSeriesTooltipFormatter.call(this, chartData);
      },
      shared: true,
      useHTML: true
    }
  };
}

function ratingHistoryTimeSeriesOptions(chartData) {
  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80
    },
    exporting: {
      enabled: true
    },
    yAxis: {
      min: 0,
      max: 10,
      tickInterval: 1,
      plotBands: ratingTimeSeriesYAxisPlotBands(ratingPlotBands(chartData.color))
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}

function smallRatingHistoryTimeSeriesOptions(chartData) {
  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: 80
    },
    legend: {
      enabled: false
    },
    yAxis: {
      max: 10,
      min: 0,
      plotBands: ratingTimeSeriesYAxisPlotBands(ratingPlotBands(chartData.color)),
      tickInterval: 1
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}

function percentageHistoryTimeSeriesOptions(chartData) {
  var options = {
    exporting: {
      enabled: true
    },
    yAxis: {
      min: 0,
      max: 100,
      minorTickInterval: 'auto',
      tickInterval: 50
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}

function percentageColorfulReformsHistoryTimeSeriesOptions(chartData) {
  var options = {
    exporting: {
      enabled: true
    },
    yAxis: {
      title: {
        text: 'Percentage'
      }
    },
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}

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
