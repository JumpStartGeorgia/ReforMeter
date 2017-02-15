function highchartTimeSeriesTooltipPointFormatter(pointData, chartData, options) {
  if (!options) options = {};

  function getLegendItem() {
    if (chartData.series.length > 1 && pointData.series.legendItem) {
      legendItem = $(pointData.series.legendItem.parentGroup.element).clone();
      legendItem.children().remove('text');
      legendItem.attr('transform', '');

      return '<svg width="50px" height="15px">' + legendItem[0].outerHTML + '</svg>';
    } else {
      return ''
    }
  }

  // Example of unit might be '%'
  function getUnit() {
    if (pointData.unit) {
      return pointData.unit
    } else {
      return ''
    }
  }

  function getValue() {
    if (chartData.use_decimals) {
      return Number(Math.round(pointData.y + 'e2') + 'e-2')
    } else {
      return Math.round(pointData.y)
    }
  }

  function getStyledValue() {
    return '<b>' + getValue() + getUnit() + '</b> ';
  }

  function getName() {
    return '<span style="color: #66666d;">' + pointData.series.name + '</span>';
  }

  function getChangeIconInSpan() {
    var changeNum = pointData.point.change

    if (changeNum) {
      var icon = getChangeIcon(changeNum);

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

function highchartTimeSeriesTooltipFormatter(tooltipData, chartData, options) {
  function getHeader() {
    var category = chartData.categories[tooltipData.x];

    return '<b>' + category + '</b><br/>';
  }

  function getPoints() {
    return tooltipData.points.map(function(pointData) {
      return highchartTimeSeriesTooltipPointFormatter(pointData, chartData, options)
    }).join('')
  }

  return getHeader() + getPoints();
}
