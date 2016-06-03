function defaultChartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

function outputHighchartsColorString(color, opacity) {
  if (!color) {
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

  return 'rgba(' + color.r + ',' + color.g + ',' + color.b + ',' + opacity + ')';
}

function highchartsGaugeLabel(chartData, point, fontSize) {
  function inDiv(content) {
    return '<div style="text-align:center;">' + content + '</div>';
  }
  var score = '<span style="font-size:' + fontSize + 'px;color:black;">' + point.y + '</span>';

  if (chartData.icon) {
    return inDiv(score + chartData.icon);
  } else {
    return inDiv(score);
  }
}
