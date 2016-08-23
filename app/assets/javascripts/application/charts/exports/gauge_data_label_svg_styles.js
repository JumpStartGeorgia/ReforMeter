// By default, the exported svg for gauge charts does not work well with
// the html in the data label. This method hacks up the gauge data label
// svg to improve its styles.
function improveDataLabelStylesInGaugeSVGExport(svg, highchartsObject, options) {
  if (!options) options = {};

  var $svg = $(svg);

  var $dataLabel = $svg.find('g.highcharts-data-labels');

  var translateRegex = /translate\((-?\d+),(-?\d+)\)/;

  function translateString(x, y) {
    return 'translate(' + x + ',' + y + ')';
  }

  function centerWholeDataLabel() {
    function replaceTranslateXWithCenteredX(_, _, currentY) {
      var centeredX = highchartsObject.chartWidth/2;
      return translateString(centeredX, currentY);
    }

    $dataLabel.attr(
      'transform',
      $dataLabel.attr('transform').replace(
        translateRegex,
        replaceTranslateXWithCenteredX
      )
    );
  }

  function removeTranslateXFromDataLabelChildren() {
    function replaceTranslateXWithZero(_, _, currentY) {
      return translateString('0', currentY);
    }

    $dataLabelChild = $dataLabel.children('g');

    $dataLabelChild.attr(
      'transform',
      $dataLabelChild.attr('transform').replace(
        translateRegex,
        replaceTranslateXWithZero
      )
    );
  }

  function alterTspanStyles() {
    var $tspans =  $dataLabel.find('tspan');
    $tspans.attr('x', 0)
    $tspans.attr('text-anchor', 'middle');

    if (options.topPadding) $tspans.slice(0, 1).attr('dy', options.topPadding);

    $tspans.slice(1).attr('dy', '1.2em').removeAttr('dx');
  }

  centerWholeDataLabel();
  removeTranslateXFromDataLabelChildren();
  alterTspanStyles();

  return $svg[0].outerHTML;
}
