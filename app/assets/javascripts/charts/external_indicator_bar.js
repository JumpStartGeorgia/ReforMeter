function updateExternalIndicatorIndeces(chartData, seriesData) {
  var $chart = $('*[data-id="' + chartData.id + '"]');
  var $indexesContainer = $chart.siblings('.js-act-as-chart-indexes-container');

  var pointArrayIndex;

  if (seriesData.point) {
    pointArrayIndex = seriesData.point.index;
  } else {
    pointArrayIndex = seriesData.points[0].point.index;
  }

  function initializeIndex($index) {
    var index_methods = {};

    var $indexValue = $index.find('.js-act-as-index-value');

    var $indexName = $index.find('.js-act-as-index-name');
    var indexNameText = $indexName.text().trim();

    var indexData = chartData.indexes.filter(function(index) {
      return index.short_name === indexNameText;
    })[0].data;

    var indexNewDataPoint = indexData[pointArrayIndex];

    index_methods.updateValue = function() {
      var newValue = Math.round(indexNewDataPoint.y);
      $indexValue.text(newValue);
    }

    index_methods.updateChange = function() {
      var newChangeIcon = change_icon(indexNewDataPoint.change);
      var $indexChange = $index.find('.js-act-as-index-change');

      $indexChange.find('.js-act-as-change-icon').attr('src', $(newChangeIcon).attr('src'));
    }

    index_methods.update = function() {
      index_methods.updateValue();
      index_methods.updateChange();
    }

    return index_methods;
  }

  var index;

  $indexesContainer.find('.js-make-index-updatable-by-chart').each(
    function() {
      index = initializeIndex($(this));
      index.update();
    }
  );
}

function highchartsExternalIndicatorBar(chartData) {
  var options = {
    chart: {
      type: 'column'
    },
    exporting: {
      enabled: true
    },
    legend: {
      enabled: false
    },
    series: chartData.series,
    title: {
      text: chartData.title
    },
    tooltip: {
      formatter: function() {
        updateExternalIndicatorIndeces(chartData, this);
        return '' + this.y;
      }
    },
    xAxis: {
      categories: chartData.categories,
      tickmarkPlacement: 'on'
    }
  };

  return Highcharts.merge(options);
}
