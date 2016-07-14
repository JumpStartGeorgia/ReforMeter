function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var options = {
    chart: {
      marginTop: externalIndicatorChart.marginTop
    },
    colors: externalIndicatorChart.colors,
    exporting: {
      enabled: true,
      chartOptions: {
        title: externalIndicatorChart.title(chartData.title)
      }
    },
    subtitle: externalIndicatorChart.subtitle(chartData.subtitle),
    title: externalIndicatorChart.title(
      chartData.title,
      {
        description: chartData.description
      }
    ),
    tooltip: {
      formatter: function() {
        return highchartTimeSeriesTooltipFormatter.call(
          this,
          chartData
        );
      }
    },
    yAxis: {
      plotBands: plotBands(chartData.plot_bands),
      title: {
        text: chartData.unitLabel
      }
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
