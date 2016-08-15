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

  if (color.r && color.g && color.b) {
    return 'rgba(' + color.r + ',' + color.g + ',' + color.b + ',' + opacity + ')';
  }

  throw new Error('Color for chart does not have the required RGB data');
}
