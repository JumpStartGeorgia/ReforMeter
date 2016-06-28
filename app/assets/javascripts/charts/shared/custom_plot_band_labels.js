function ratingPlotBands(labelColor) {
  return [
    {
      from: 0,
      to: 3,
      label: {
        text: 'Behind',
        style: {
          color: outputHighchartsColorString(labelColor, '.6')
        }
      }
    }, {
      from: 3,
      to: 6.5,
      label: {
        text: 'On Track',
        style: {
          color: outputHighchartsColorString(labelColor, '.8')
        }
      }
    }, {
      from: 6.5,
      to: 10,
      label: {
        text: 'Ahead',
        style: {
          color: outputHighchartsColorString(labelColor, '1')
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
      this.label.style.fontSize = '16px';
      this.label.style.fontWeight = '600';
    }
  );

  return plotBands;
}
