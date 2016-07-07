function highchartsGaugeLabel(chartData, point, fontSize, args) {
  if (!args) args = {};

  var unit = args.unit;
  if (!unit) unit = '';

  var color = args.color;
  if (!color) color = 'black';

  function inDiv(content) {
    return '<div style="text-align:center;">' + content + '</div>';
  }
  var score = '<span style="font-size:' + fontSize + ';color:' + color + ';">' + point.y + unit + '</span>';

  if (chartData.change === null) {
    return inDiv(score);
  } else {
    var icon = change_icon(chartData.change);
    var iconInSpan = '<span style="width: ' + fontSize + '; display: inline-block;">' + icon + '</span>';

    return inDiv(score + iconInSpan);
  }
}
