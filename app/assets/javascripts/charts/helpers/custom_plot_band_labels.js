function ratingTimeSeriesYAxisPlotBands(labelColor) {
  var horizontalDisplacement = -100;
  var verticalAlign = 'top';
  var fontSize = '1.6rem';
  var fontWeight = '600';

  var plotBands = [
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

  $(plotBands).each(
    function() {
      this.label.x = horizontalDisplacement;
      this.label.verticalAlign = verticalAlign;
      this.label.style.fontSize = fontSize;
      this.label.style.fontWeight = fontWeight;
    }
  );

  return plotBands;
}
