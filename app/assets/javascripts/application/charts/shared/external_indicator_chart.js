function externalIndicatorChartHelpers(chartData) {
  var externalIndicatorChart = {};

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

  function chartSpacingLeft() {
    if (!chartData.plot_bands || chartData.plot_bands.length === 0) return 0;

    return localeIs('ka') ? 120 : 80;
  }

  externalIndicatorChart.spacingLeft = chartSpacingLeft();

  // plotBands is array of plot bands from chartData
  // create settings for each plot band
  externalIndicatorChart.plotBands = function(plotBands, use_opacity) {
    var bands = [];
    if (use_opacity === undefined){
      use_opacity = true;
    }
    $(plotBands).each(function() {
      bands.push({
        from: this.from,
        to: this.to,
        label: {
          text: this.text,
          style: {
            color: outputHighchartsColorString(externalIndicatorChart.colorHash, use_opacity == true ? this.opacity : 1),
            fontSize: localeIs('ka') ? '14px' : '16px',
            fontWeight: '600'
          },
          x: localeIs('ka') ? -140 : -100,
          verticalAlign: 'middle'
        }
      });
    });

    return bands;
  }

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
        textTransform: 'uppercase',
        paddingBottom: typeof chartData.subtitle === 'string' ? '0' : '10px'
      },
      text: text + infoCircle,
      widthAdjust: 0,
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
        fontWeight: '200',
        paddingBottom: '20px'
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
};
