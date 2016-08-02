function highchartsExternalIndicatorBar(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var spacingLeft = chartData.plot_bands != null ? localeIs('ka') ? 120 : 80 : 0;

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
      marginTop: externalIndicatorChart.marginTop,
      type: 'column'
    },
    colors: colors(),
    exporting: {
      enabled: true,
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
      plotBands: plotBands(chartData.plot_bands, false),
      title: {
        text: chartData.unitLabel
      }
    }
  };

  return Highcharts.merge(options);
}
