function updateExternalIndicatorIndeces(chartData, seriesData) {
  var $chart = $('*[data-id="' + chartData.id + '"]');
  var $indexesContainer = $chart.siblings('.js-act-as-chart-indexes-container');

  var indexBox;

  $indexesContainer.find('.js-make-index-updatable-by-chart').each(
    function() {
      indexBox = initializeIndexBox(chartData.indexes, $(this));
      indexBox.update(seriesData);
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
