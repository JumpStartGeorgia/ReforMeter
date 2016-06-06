function historyTimeSeriesOptions(chartData) {
  function pointFormatter() {
    function in_paragraph(content) {
      return '<p style="margin: 5px 0;">' + content + '</p>';
    }

    var point = '<b>' + this.y + '</b> ';
    var name = '<span style="color: #66666d;">' + this.series.name + '</span>';

    if (this.change) {
      var icon = change_icon(this.change);

      var iconInSpan = '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';

      return in_paragraph(point + iconInSpan + name);
    } else {
      return in_paragraph(point + name);
    }
  }

  function areasplineFillColors() {
    var topColor;
    var bottomColor;

    if (chartData.color) {
      var color = chartData.color;
      bottomColor = outputHighchartsColorString(chartData.color, '.6');
      topColor = outputHighchartsColorString(chartData.color, '1');
    } else {
      bottomColor = defaultChartColors()[2];
      topColor = defaultChartColors()[0];
    }

    return [
      [0, topColor],
      [1, bottomColor]
    ];
  }

  function highchartDownloadIcon() {
    if (!gon.chart_download_icon) {
      throw new Error('Chart download icon not available');
    }

    return 'url(' + gon.chart_download_icon + ')';
  }

  return {
    chart: {
      zoomType: 'x',
      type: 'spline'
    },
    exporting: {
      buttons: {
        contextButton: {
          symbol: highchartDownloadIcon()
        }
      }
    },
    title: {
      text: null
    },
    colors: ['#000'],
    xAxis: {
      type: 'datetime',
      categories: chartData.categories,
      crosshair: {
        color: 'black',
        dashStyle: 'solid',
        width: 1,
        zIndex: 99
      },
      tickmarkPlacement: 'on'
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
        fillColor: {
          linearGradient: {
            x1: 0,
            y1: 0,
            x2: 0,
            y2: 1
          },
          stops: areasplineFillColors()
        },
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
      headerFormat: '<b>{point.key}</b><br/>',
      pointFormatter: pointFormatter,
      shared: true,
      useHTML: true
    }
  };
}

function ratingHistoryTimeSeriesOptions(chartData) {
  var options = {
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
    yAxis: {
      title: {
        text: 'Percentage'
      }
      // min: 0,
      // max: 100,
      // minorTickInterval: 'auto',
      // tickInterval: 50
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
