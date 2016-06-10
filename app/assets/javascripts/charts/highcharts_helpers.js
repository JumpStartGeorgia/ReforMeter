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

function highchartTimeSeriesTooltipPointFormatter() {
  function in_paragraph(content) {
    return '<p style="margin: 5px 0;">' + content + '</p>';
  }

  var point = '<b>' + this.y + '</b> ';
  var name = '<span style="color: #66666d;">' + this.series.name + '</span>';

  if (this.change) {
    var icon = change_icon(this.change);

    var iconInSpan = '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';

    return in_paragraph(point + iconInSpan + name);
  } else {
    return in_paragraph(point + name);
  }
}
