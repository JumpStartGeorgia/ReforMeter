function highchartsExternalIndicatorBar(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);

  var options = {
    chart: {
      type: 'column'
    },
    colors: [
      outputHighchartsColorString(externalIndicatorChart.color, 1),
      outputHighchartsColorString(externalIndicatorChart.color, 0.8),
      outputHighchartsColorString(externalIndicatorChart.color, 0.6),
      outputHighchartsColorString(externalIndicatorChart.color, 0.4)
    ],
    exporting: {
      enabled: true
    },
    legend: {
      enabled: false
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
    xAxis: {
      categories: chartData.categories,
      tickmarkPlacement: 'on'
    }
  };

  return Highcharts.merge(options);
}
