function highchartTimeSeriesTooltipPointFormatter(point, chartData, options) {
  if (!options) options = {};

  function getLegendItem() {
    if (chartData.series.length > 1 && point.series.legendItem) {
      legendItem = $(point.series.legendItem.parentGroup.element).clone();
      legendItem.children().remove('text');
      legendItem.attr('transform', '');

      return '<svg width="50px" height="15px">' + legendItem[0].outerHTML + '</svg>';
    } else {
      return ''
    }
  }

  // Example of unit might be '%'
  function getUnit() {
    if (point.unit) {
      return point.unit
    } else {
      return ''
    }
  }

  function getValue() {
    if (chartData.use_decimals) {
      return Number(Math.round(point.y + 'e2') + 'e-2')
    } else {
      return Math.round(point.y)
    }
  }

  function getStyledValue() {
    return '<b>' + getValue() + getUnit() + '</b> ';
  }

  function getName() {
    return '<span style="color: #66666d;">' + point.series.name + '</span>';
  }

  function getChangeIconInSpan() {
    if (point.change) {
      var icon = getChangeIcon(point.change);

      return '<span style="width: 14px; display: inline-block; vertical-align: middle;">' + icon + '</span>';
    } else {
      return ''
    }
  }

  function surroundInParagraph(content) {
    return '<p style="margin: 5px 0;">' + content + '</p>';
  }

  return surroundInParagraph(
    getLegendItem() + getStyledValue() + getChangeIconInSpan() + getName()
  );
}

function highchartTimeSeriesTooltipFormatter(selectedPoints, chartData, options) {
  function getHeader() {
    var category = chartData.categories[selectedPoints.x];

    return '<b>' + category + '</b><br/>';
  }

  function getPoints() {
    return selectedPoints.points.map(function(point) {
      return highchartTimeSeriesTooltipPointFormatter(point, chartData, options)
    }).join('')
  }

  return getHeader() + getPoints();
}
