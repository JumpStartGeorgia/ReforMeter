function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var externalIndicatorChart = externalIndicatorChartHelpers(chartData);

  var spacingLeft = chartData.plot_bands != null ? localeIs('ka') ? 120 : 80 : 0;

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft
    },
    colors: externalIndicatorChart.colors,
    exporting: {
      chartOptions: {
        title: externalIndicatorChart.title(
          chartData.title,
          {
            titleOptions: {
              x: -1 * spacingLeft + 10
            }
          }
        )
      }
    },
    subtitle: externalIndicatorChart.subtitle(
      chartData.subtitle,
      {
        x: -1 * spacingLeft + 10
      }
    ),
    title: externalIndicatorChart.title(
      chartData.title,
      {
        description: chartData.description,
        titleOptions: {
          x: -1 * spacingLeft + 10
        }
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
      plotBands: externalIndicatorChart.plotBands(chartData.plot_bands, false),
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
