function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var externalIndicatorChart = externalIndicatorChartHelpers(chartData);

  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.colorHash;
  var max = chartData.max;
  var spacingLeft = localeIs('ka') ? 120 : 80;

  function plotBands(plotBands) {

    $(plotBands).each(
      function() {
        // Fixes plot band format to work with highcharts
        function fixPlotBandFormat(plotBand) {
          if (!plotBand.label) {
            plotBand.label = {};

            if (plotBand.text) {
              plotBand.label.text = this.text;
              delete plotBand.text;
            }
          }

          if (!plotBand.label.style) plotBand.label.style = {};
        }

        fixPlotBandFormat(this);

        this.label.x = localeIs('ka') ? -140 : -100;
        this.label.verticalAlign = 'middle';
        this.label.style.fontSize = localeIs('ka') ? '1.4em' : '1.6em';
        this.label.style.fontWeight = '600';
      }
    );

    return plotBands;
  }

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      type: 'areaspline'
    },
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
    legend: {
      enabled: false
    },
    plotOptions: {
      areaspline: {
        color: '#f7d95c',
        fillColor: {
          linearGradient: {
            x1: 0,
            y1: 0,
            x2: 0,
            y2: 1
          },
          stops: [
            [0, '#faa24f'],
            [1, '#f7d95c']
          ]
        },
        lineWidth: 0,
        marker: {
          enabled: false
        }
      }
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

        return externalIndicatorChart.tooltipFormatter(this.points[0]);
      },
      style: {
        fontSize: '2em',
        fontWeight: '600'
      },
      useHTML: true
    },
    yAxis: {
      min: chartData.min,
      max: chartData.max,
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
