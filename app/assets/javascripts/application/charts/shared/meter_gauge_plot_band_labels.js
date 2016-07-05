var meterGaugePlotBandLabels = (function() {
  var exports = {},
      color = 'white'

  exports.behind = function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.behind,
        rotation: -60,
        x: 55,
        y: 60,
        style: {
          fontSize: gon.locale === 'ka' ? '17px' : '18px',
          color: 'white'
        }
      },
      options
    );
  }

  exports.onTrack = function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.on_track,
        x: 88,
        y: 20,
        style: {
          fontSize: gon.locale === 'ka' ? '17px' : '18px',
          color: color
        }
      },
      options
    );
  }

  exports.ahead = function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.ahead,
        rotation: 60,
        x: localeIs('ka') ? 170 : 173,
        y: localeIs('ka') ? 25 : 35,
        style: {
          fontSize: localeIs('ka') ? '17px' : '18px',
          color: 'white'
        }
      },
      options
    );
  }

  return exports;
})();
