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
      type: 'datetime',
      categories: chartData.categories,
      labels: {
        enabled: false
      },
      tickmarkPlacement: 'on',
      visible: false
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
      headerFormat: '<b>{point.key}</b><br/>',
      pointFormatter: highchartTimeSeriesTooltipPointFormatter,
      shared: true,
      useHTML: true
    }
  }
}
