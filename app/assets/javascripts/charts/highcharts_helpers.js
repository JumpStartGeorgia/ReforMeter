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
