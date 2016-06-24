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
      align: 'right',
      enabled: chartData.series.length > 1
    },
    series: chartData.series,
    subtitle: externalIndicatorChart.subtitle(
      chartData.subtitle
    ),
    title: externalIndicatorChart.title(
      chartData.title
    ),
    tooltip: {
      backgroundColor: '#f3f3f4',
      formatter: function() {
        indexBoxes.update(this);

        return externalIndicatorChart.tooltipFormatter(
          this,
          {
            seriesName: chartData.series.length > 1
          }
        );
      },
      style: {
        fontSize: '2rem',
        fontWeight: '600'
      },
      useHTML: true
    },
    xAxis: {
      categories: chartData.categories,
      tickmarkPlacement: 'on'
    }
  };

  return Highcharts.merge(options);
}
