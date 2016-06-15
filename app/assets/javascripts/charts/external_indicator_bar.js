function updateExternalIndicatorIndeces(chartData, seriesData) {
  var $chart = $('*[data-id="' + chartData.id + '"]');
  var $indexesContainer = $chart.siblings('.js-act-as-chart-indexes-container');

  var pointArrayIndex = seriesData.point.index;

  function updateIndex() {
    var $index = $(this);
    var $indexName = $index.find('.js-act-as-index-name');
    var indexNameText = $indexName.text().trim();

    var indexData = chartData.indexes.filter(function(index) {
      return index.short_name === indexNameText;
    })[0].data;

    var indexNewDataPoint = indexData[pointArrayIndex];

    function updateIndexValue(newValue) {
      var $indexValue = $index.find('.js-act-as-index-value');
      $indexValue.text(newValue);
    }

    function updateIndexChange(newChangeIcon) {
      var $indexChange = $index.find('.js-act-as-index-change');
      $indexChange.text(newChangeIcon);
    }

    updateIndexValue(Math.round(indexNewDataPoint.y));
    // updateIndexChange(change_icon(indexNewDataPoint.change));
  }

  $indexesContainer.find('.js-make-index-updatable-by-chart').each(updateIndex);
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
