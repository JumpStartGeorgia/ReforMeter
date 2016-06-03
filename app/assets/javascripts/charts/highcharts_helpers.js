function defaultChartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

function outputHighchartsColorString(color, opacity) {
  if (!opacity) {
    opacity = '1';
  }
  return 'rgba(' + color.r + ',' + color.g + ',' + color.b + ',' + opacity + ')';
}
