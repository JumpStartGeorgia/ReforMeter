function highchartsExternalIndicatorLineTimeSeries(chartData) {
  var externalIndicatorChart = externalIndicatorChartHelpers(chartData);
  var spacingLeft = externalIndicatorChart.spacingLeft;

  if (typeof(chartData.displayTitle) === 'undefined') chartData.displayTitle = true;
  if (typeof(chartData.displaySubtitle) === 'undefined') chartData.displaySubtitle = true;

  var benchmarkSeries = chartData.series.filter(function(seriesObject) {
    return seriesObject.isBenchmark
  })[0]

  if (benchmarkSeries) {
    Object.assign(
      benchmarkSeries,
      {
        color: '#3b2f76',
        lineWidth: 4,
        dashStyle: 'Solid'
      }
    )
  }

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
      chartData.displaySubtitle ? chartData.subtitle : null,
      {
        x: -1 * spacingLeft + 10
      }
    ),
    title: externalIndicatorChart.title(
      chartData.displayTitle ? chartData.title : null,
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
