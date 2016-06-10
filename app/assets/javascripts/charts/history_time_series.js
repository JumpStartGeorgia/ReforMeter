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
    exporting: {
      enabled: true
    },
    yAxis: {
      min: 0,
      max: 10,
      tickInterval: 1,
      title: {
        text: 'Rating'
      }
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}

function smallRatingHistoryTimeSeriesOptions(chartData) {
  var options = {
    legend: {
      enabled: false
    },
    yAxis: {
      min: 0,
      max: 10,
      tickInterval: 1,
      title: {
        text: 'Rating'
      }
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
