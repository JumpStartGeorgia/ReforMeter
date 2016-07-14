function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.colorHash;
  var spacingLeft = localeIs('ka') ? 120 : 80;

  // plotBands is array of plot bands from chartData
  // create settings for each plot band
  function plotBands(plotBands) {
    var bands = [];
    $(plotBands).each(function() {
      bands.push({
        from: this.from,
        to: this.to,
        label: {
          text: this.text,
          style: {
            color: outputHighchartsColorString(color, this.opacity),
            fontSize: localeIs('ka') ? '14px' : '16px',
            fontWeight: '600'
          },
          x: localeIs('ka') ? -140 : -100,
          verticalAlign: 'middle'
        }
      });
    });

    return bands;
  }

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      marginTop: externalIndicatorChart.marginTop,
      type: 'areaspline'
    },
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
      backgroundColor: '#f3f3f4',
      formatter: function() {
        indexBoxes.update(this);

        return externalIndicatorChart.tooltipFormatter(this.points[0]);
      },
      style: {
        fontSize: '2rem',
        fontWeight: '600'
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
