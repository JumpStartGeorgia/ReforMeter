function highchartsExternalIndicatorBar(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);

  var options = {
    chart: {
      marginTop: externalIndicatorChart.marginTop,
      type: 'column'
    },
    colors: externalIndicatorChart.colors,
    exporting: {
      enabled: true
    },
    legend: {
      enabled: false
    },
    series: chartData.series,
    subtitle: externalIndicatorChart.subtitle(
      chartData.subtitle
    ),
    title: externalIndicatorChart.title(
      chartData.title
    ),
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
