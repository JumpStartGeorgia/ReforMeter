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
    exporting: {
      sourceWidth: 1410,
      sourceHeight: 600
    },
    title: {
      text: null
    },
    colors: ['#0e3a5b'],
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
        lineWidth: 2.5,
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
