function initializeIndexBox(chartDataIndexes, $index) {
  var index_methods = {};

  $index.tipsy(
    {
      className: 'chartIndexes-item-tooltip',
      gravity: $.fn.tipsy.autoNS,
      html: true,
      opacity: 1
    }
  );

  var $indexValue = $index.find('.js-act-as-index-value');

  var $indexName = $index.find('.js-act-as-index-name');
  var indexNameText = $indexName.text().trim();

  var indexData = chartDataIndexes.filter(function(index) {
    return index.short_name === indexNameText;
  })[0].data;

  index_methods.updateValue = function(newValue) {
    $indexValue.text(newValue);
  }

  index_methods.updateChange = function(newChangeIcon) {
    $index.find('.js-act-as-change-icon').attr('src', $(newChangeIcon).attr('src'));
  }

  index_methods.update = function(seriesData) {
    var pointArrayIndex;

    if (seriesData.point) {
      pointArrayIndex = seriesData.point.index;
    } else {
      pointArrayIndex = seriesData.points[0].point.index;
    }

    var indexNewDataPoint = indexData[pointArrayIndex];
    var newValue = Math.round(indexNewDataPoint.y);
    var newChangeIcon = change_icon(indexNewDataPoint.change);

    index_methods.updateValue(newValue);
    index_methods.updateChange(newChangeIcon);
  }

  return index_methods;
}
