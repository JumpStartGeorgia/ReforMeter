function expertHistoryTimeSeriesChart() {
  var expertHistoryTimeSeries = {
    create: function() {
      $('.js-become-experts-time-series-chart').highcharts({
        chart: {
          zoomType: 'x',
          type: 'line'
        },
        colors: ['#000'],
        xAxis: {
          type: 'datetime',
          categories: gon.survey_data.categories,
          tickmarkPlacement: 'on'
        },
        yAxis: {
          title: {
            text: 'Rating'
          },
          gridLineDashStyle: 'dot'
        },
        plotOptions: {
          area: {
            fillColor: {
              linearGradient: {
                x1: 0,
                y1: 0,
                x2: 0,
                y2: 1
              },
              stops: [
                [0, Highcharts.getOptions().colors[0]],
                [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
              ]
            }
          }
        },
        series: gon.survey_data.series
      });
    }
  }

  return expertHistoryTimeSeries;
}
