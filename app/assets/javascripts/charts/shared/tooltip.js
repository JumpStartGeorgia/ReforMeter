function highchartTimeSeriesTooltipPointFormatter(point, options) {
  if (!options) options = {};

  // Use unit if specified, otherwise use empty string
  var unit;
  if (point.unit) {
    unit = point.unit;
  } else {
    unit = '';
  }

  var legendItem = '';

  if (point.series.legendItem) {
    legendItem = $(point.series.legendItem.parentGroup.element).clone();
    legendItem.children().remove('text');
    legendItem.attr('transform', '');

    legendItem = '<svg width="50px" height="15px">' + legendItem[0].outerHTML + '</svg>';
  }

  var pointScore = '<b>' + point.y + unit + '</b> ';

  var name = '<span style="color: #66666d;">' + point.series.name + '</span>';

  var iconInSpan = '';

  if (point.change) {
    var icon = change_icon(point.change);

    iconInSpan = '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';
  }

  function in_paragraph(content) {
    return '<p style="margin: 5px 0;">' + content + '</p>';
  }


  var fullLine = in_paragraph(legendItem + pointScore + iconInSpan + name);

  return fullLine;
}

function highchartTimeSeriesTooltipFormatter(chartData, options) {
  var text = '';
  var category = chartData.categories[this.x];
  var header = '<b>' + category + '</b><br/>';
  text += header;

  for (var i = 0; i < this.points.length; i++) {
    text += highchartTimeSeriesTooltipPointFormatter(this.points[i].point, options);
  }

  return text;
}
