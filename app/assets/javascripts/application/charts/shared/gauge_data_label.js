function highchartsGaugeLabel(chartData, point, fontSize, args) {
  if (!args) args = {};

  var unit = args.unit;
  if (!unit) unit = '';

  var color = args.color;
  if (!color) color = 'black';

  function inDiv(content) {
    return '<div style="text-align:center;">' + content + '</div>';
  }

  var gaugeLabel = '';

  gaugeLabel += '<span style="vertical-align: middle; font-size:' + fontSize + '; color:' + color + ';">' + point.y + unit + '</span>';

  changeIcon = true; // show change icon by default
  if (args.changeIcon === false) changeIcon = false;

  if (changeIcon && [-1, 0, 1].includes(chartData.change)) {
    var icon = change_icon(chartData.change);

    gaugeLabel += '<span style="vertical-align: middle; width: ' + fontSize + ';height: ' + fontSize + ';display: inline-block;">' + icon + '</span>';
  }

  if (args.secondLineText) {
    gaugeLabel += '<p style="margin: 0;">' + args.secondLineText + '</p>';
  }

  return inDiv(gaugeLabel);
}
