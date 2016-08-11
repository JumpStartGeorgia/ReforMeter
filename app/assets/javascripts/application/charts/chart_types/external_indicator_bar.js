function highchartsExternalIndicatorBar(chartData) {
  var externalIndicatorChart = externalIndicatorChartHelpers(chartData);
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var spacingLeft = externalIndicatorChart.spacingLeft;

  if (typeof(chartData.displayTitle) === 'undefined') chartData.displayTitle = true;
  if (typeof(chartData.displaySubtitle) === 'undefined') chartData.displaySubtitle = true;

  function colors() {
    if (chartData.series.length > 1) {
      return externalIndicatorChart.colors;
    } else {
      return [externalIndicatorChart.colors[3]];
    }
  }

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      type: 'column'
    },
    colors: colors(),
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
      },
      sourceWidth: 1410,
      sourceHeight: 600
    },
    legend: {
      align: 'right',
      enabled: chartData.series.length > 1
    },
    series: chartData.series,
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
        indexBoxes.update(this);

        return externalIndicatorChart.tooltipFormatter(
          this,
          {
            seriesName: chartData.series.length > 1
          }
        );
      },
      style: {
        fontSize: '2em',
        fontWeight: '600'
      },
      useHTML: true
    },
    xAxis: {
      categories: chartData.categories,
      tickmarkPlacement: 'on'
    },
    yAxis: {
      min: chartData.min,
      max: chartData.max,
      plotBands: externalIndicatorChart.plotBands(chartData.plot_bands, false),
      title: {
        text: chartData.unitLabel
      }
    }
  };

  return Highcharts.merge(options);
}
