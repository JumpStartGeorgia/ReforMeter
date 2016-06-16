function change_icon(change_number) {
  if (!gon.change_icons) {
    throw new Error('Change icons not available');
  }

  return gon.change_icons[change_number]
}

function defaultChartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

function outputHighchartsColorString(color, opacity, fallback) {
  if (!color) {

    if (fallback) {
      return fallback;
    } else {

      switch (opacity) {

        case '.6': {
          return defaultChartColors()[2];
        }

        case '.8': {
          return defaultChartColors()[1];
        }

        case '1': {
          return defaultChartColors()[0];
        }

      }
    }

  }

  return 'rgba(' + color.r + ',' + color.g + ',' + color.b + ',' + opacity + ')';
}

function highchartsGaugeLabel(chartData, point, fontSize, args) {
  if (!args) args = {};

  var unit = args.unit;
  if (!unit) unit = '';

  var color = args.color;
  if (!color) color = 'black';

  function inDiv(content) {
    return '<div style="text-align:center;">' + content + '</div>';
  }
  var score = '<span style="font-size:' + fontSize + 'px;color:' + color + ';">' + point.y + unit + '</span>';

  if (chartData.change === null) {
    return inDiv(score);
  } else {
    var icon = change_icon(chartData.change);
    var iconInSpan = '<span style="width: ' + fontSize + 'px; display: inline-block; vertical-align: middle;">' + icon + '</span>';

    return inDiv(score + iconInSpan);
  }
}

function highchartDownloadIcon() {
  if (!gon.chart_download_icon) {
    throw new Error('Chart download icon not available');
  }

  return 'url(' + gon.chart_download_icon + ')';
}

function highchartTimeSeriesTooltipPointFormatter(point) {
  // Use unit if specified, otherwise use empty string
  var unit;
  if (point.unit) {
    unit = point.unit;
  } else {
    unit = '';
  }

  function in_paragraph(content) {
    return '<p style="margin: 5px 0;">' + content + '</p>';
  }

  var pointScore = '<b>' + point.y + unit + '</b> ';

  var name = '<span style="color: #66666d;">' + point.series.name + '</span>';

  if (point.change) {
    var icon = change_icon(point.change);

    var iconInSpan = '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';

    return in_paragraph(pointScore + iconInSpan + name);
  } else {
    return in_paragraph(pointScore + name);
  }
}

function highchartTimeSeriesTooltipFormatter(chartData) {
  var text = '';
  var category = chartData.categories[this.x];
  var header = '<b>' + category + '</b><br/>';
  text += header;

  for (var i = 0; i < this.points.length; i++) {
    text += highchartTimeSeriesTooltipPointFormatter(this.points[i].point);
  }

  return text;
}

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
