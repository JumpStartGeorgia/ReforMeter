function expertHistoryTimeSeriesChart() {
  function pointFormatter() {
    function in_paragraph(content) {
      return '<p style="margin: 5px 0;">' + content + '</p>';
    }

    var point = '<b>' + this.y + '</b> ';

    var icon = '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + change_icon(this.change) + '</span>';
    var name = '<span style="color: #66666d;">' + this.series.name + '</span>';

    if (this.change) {
      return in_paragraph(point + icon + name);
    } else {
      return in_paragraph(point + name);
    }
  }

  var expertHistoryTimeSeries = {
    create: function() {
      $('.js-become-experts-time-series-chart').highcharts({
        chart: {
          zoomType: 'x',
          type: 'spline'
        },
        title: {
          text: null
        },
        colors: ['#000'],
        xAxis: {
          type: 'datetime',
          categories: gon.charts.survey_data.categories,
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
          title: {
            text: 'Rating'
          },
          tickInterval: 1,
          gridLineDashStyle: 'dot',
          min: 0,
          max: 10
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
              stops: [
                [0, chartColors()[0]],
                [1, chartColors()[2]]
              ]
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
        series: gon.charts.survey_data.series,
        tooltip: {
          backgroundColor: 'white',
          borderWidth: 0,
          headerFormat: '<b>{point.key}</b><br/>',
          pointFormatter: pointFormatter,
          shared: true,
          useHTML: true
        }
      });
    }
  }

  return expertHistoryTimeSeries;
}
