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
