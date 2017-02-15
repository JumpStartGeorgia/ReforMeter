function highchartTimeSeriesTooltipPointFormatter(point, options) {
  if (!options) options = {};

  // Example of unit might be '%'
  function getUnit() {
    if (point.unit) {
      return point.unit
    } else {
      return ''
    }
  }

  function getLegendItem() {
    if (point.series.legendItem) {
      legendItem = $(point.series.legendItem.parentGroup.element).clone();
      legendItem.children().remove('text');
      legendItem.attr('transform', '');

      return '<svg width="50px" height="15px">' + legendItem[0].outerHTML + '</svg>';
    } else {
      return ''
    }
  }

  function getPointScore() {
    return '<b>' + point.y + getUnit() + '</b> ';
  }

  function getName() {
    return '<span style="color: #66666d;">' + point.series.name + '</span>';
  }

  function getChangeIconInSpan() {
    if (point.change) {
      var icon = change_icon(point.change);

      return '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';
    } else {
      return ''
    }
  }

  function surroundInParagraph(content) {
    return '<p style="margin: 5px 0;">' + content + '</p>';
  }

  return surroundInParagraph(
    getLegendItem() + getPointScore() + getChangeIconInSpan() + getName()
  );
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
