var externalIndicatorChart = (function() {
  var externalIndicatorChart = {};

  externalIndicatorChart.marginTop = 90;

  externalIndicatorChart.colorHash = {
    r: '250',
    g: '162',
    b: '79'
  };

  externalIndicatorChart.colors = [
      '#ed7818',
      '#ef8a22',
      '#f19c2b',
      '#f4ae35',
      '#f6c03f',
      '#f8d248',
      '#f9db4d'
    ];

  externalIndicatorChart.title = function(text, customOptions) {
    if (!customOptions) customOptions = {};

    var infoCircle = '';

    if (customOptions.description) {
      infoCircle = "<span class='infoCircle js-act-as-info-circle' original-title='" + customOptions.description + "'>i</span>"
    }

    var options = {
      align: 'left',
      style: {
        fontWeight: 600,
        fontSize: '2em',
        textTransform: 'uppercase'
      },
      text: text + infoCircle,
      useHTML: true
    };

    if (customOptions.titleOptions) {
      options = mergeObjects(options, customOptions.titleOptions);
    }
    return options;
  }

  externalIndicatorChart.tooltipFormatter = function(pointData, args) {
    if (!args) args = {};

    var seriesName = '';

    if (args.seriesName) {
      seriesName = pointData.series.name + '</br>';
    }

    var value = '<span style="vertical-align: middle;">' + Math.round(pointData.y) + '</span>';

    var iconInSpan = '';

    if ([-1, 0, 1].includes(pointData.point.change)) {
      var icon = change_icon(
        pointData.point.change
      );
      
      iconInSpan = '<span style="width: 20px; display: inline-block; vertical-align: middle;">' + icon + '</span>';
    }

    return seriesName + value + iconInSpan;
  }

  externalIndicatorChart.subtitle = function(text, customOptions) {
    var options = {
      align: 'left',
      style: {
        color: '#66666d',
        fontSize: '1.6em',
        fontWeight: '200'
      },
      text: text,
      useHTML: true
    };

    if (customOptions) {
      options = mergeObjects(options, customOptions);
    }

    return options;
  }

  return externalIndicatorChart;
})();
