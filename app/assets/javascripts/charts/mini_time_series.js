function miniTimeSeries(chartData) {
  // return {
  //   colors: ['#000'],
  // };

  return {
    chart: {
      zoomType: 'x',
      type: 'areaspline',
      height: null,
      width: null
    },
    legend: {
      enabled: false
    },
    plotOptions: {
      areaspline: {
        color: chartData.color.hex,
        fillColor: '#e8e8e8',
        lineWidth: 5,
        marker: {
          enabled: false
        }
      }
    },
    title: {
      text: null
    },
    xAxis: {
      // Using labels instead of categories to make x axis start and end on tick
      // Source: http://stackoverflow.com/questions/18593883/highcharts-remove-gap-between-start-of-xaxis-and-first-value
      labels: {
        enabled: true,
        formatter: function () {
            return chartData.categories[this.value];
        }
      },
      tickmarkPlacement: 'on',
      type: 'datetime',
      visible: true
    },
    yAxis: {
      title: {
        text: null
      },
      labels: {
        enabled: false
      },
      visible: false
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
  }
}
