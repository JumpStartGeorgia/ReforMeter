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

  if (chartData.change) {
    var icon = change_icon(chartData.change);
    
    gaugeLabel += '<span style="vertical-align: middle; width: ' + fontSize + ';height: ' + fontSize + ';display: inline-block;">' + icon + '</span>';
  }
  
  return inDiv(gaugeLabel);
}
