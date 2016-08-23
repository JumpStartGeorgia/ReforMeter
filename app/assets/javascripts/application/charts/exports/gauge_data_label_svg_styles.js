// By default, the exported svg for gauge charts does not work well with
// the html in the data label. This method hacks up the gauge data label
// svg to improve its styles.
function improveDataLabelStylesInGaugeSVGExport(svg, highchartsObject, options) {
  if (!options) options = {};
  if (!options.topPadding) options.topPadding = false;

  var $svg = $(svg);

  var $dataLabel = $svg.find('g.highcharts-data-labels');

  function translateString(x, y) {
    return 'translate(' + x + ',' + y + ')';
  }

  function replaceTranslateXWithCenteredX(_, _, currentY) {
    var centeredX = highchartsObject.chartWidth/2;
    return translateString(centeredX, currentY);
  }

  var translateRegex = /translate\((-?\d+),(-?\d+)\)/;

  var newDataLabelTransform = $dataLabel
                              .attr('transform')
                              .replace(
                                translateRegex,
                                replaceTranslateXWithCenteredX
                              );

  $dataLabel.attr('transform', newDataLabelTransform);

  $dataLabelChild = $dataLabel.children('g');

  function replaceTranslateXWithZero(_, _, currentY) {
    return translateString('0', currentY);
  }

  $dataLabelChild.attr(
    'transform',
    $dataLabelChild.attr('transform').replace(
      translateRegex,
      replaceTranslateXWithZero
    )
  );

  var $tspans =  $dataLabel.find('tspan');
  $tspans.attr('x', 0)
  $tspans.attr('text-anchor', 'middle');

  if (options.topPadding) $tspans.slice(0, 1).attr('dy', '.5em');

  $tspans.slice(1).attr('dy', '1.2em').removeAttr('dx');
  return $svg[0].outerHTML;
}
