function ratingTimeSeriesYAxisPlotBands(labelColor) {
  var horizontalDisplacement = -100;
  var verticalAlign = 'top';
  var fontSize = '1.6rem';
  var fontWeight = '600';

  return [
    {
      from: 0,
      to: 3,
      label: {
        text: 'Behind',
        x: horizontalDisplacement,
        verticalAlign: verticalAlign,
        style: {
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: outputHighchartsColorString(labelColor, '.6')
        }
      }
    }, {
      from: 3,
      to: 6.5,
      label: {
        text: 'On Track',
        x: horizontalDisplacement,
        verticalAlign: verticalAlign,
        style: {
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: outputHighchartsColorString(labelColor, '.8')
        }
      }
    }, {
      from: 6.5,
      to: 10,
      label: {
        text: 'Ahead',
        x: horizontalDisplacement,
        verticalAlign: verticalAlign,
        style: {
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: outputHighchartsColorString(labelColor, '1')
        }
      }
    }
  ]
}
