function ratingPlotBands(chartData) {
  return [
    {
      from: 0,
      to: 3,
      label: {
        text: chartData.translations.behind,
        style: {
          color: outputHighchartsColorString(chartData.color, '.6')
        }
      }
    }, {
      from: 3,
      to: 6.5,
      label: {
        text: chartData.translations.on_track,
        style: {
          color: outputHighchartsColorString(chartData.color, '.8')
        }
      }
    }, {
      from: 6.5,
      to: 10,
      label: {
        text: chartData.translations.ahead,
        style: {
          color: outputHighchartsColorString(chartData.color, '1')
        }
      }
    }
  ]
}

function customTimeSeriesPlotBands(plotBands) {
  $(plotBands).each(
    function() {
      this.label.x = -100;
      this.label.verticalAlign = 'middle';
      this.label.style.fontSize = localeIs('ka') ? '1.4em' : '1.6em';
      this.label.style.fontWeight = '600';
    }
  );

  return plotBands;
}
