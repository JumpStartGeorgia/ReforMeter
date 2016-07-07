var meterGaugePlotBandLabels = (function() {
  var exports = {},
      color = 'white';

  exports.behind = function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.behind,
        rotation: -60,
        x: 55,
        y: localeIs('ka') ? 55 : 60,
        style: {
          fontSize: gon.locale === 'ka' ? '1.5em' : '1.6em',
          color: color
        }
      },
      options
    );
  }

  exports.onTrack = function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.on_track,
        x: 94,
        y: 14,
        style: {
          fontSize: gon.locale === 'ka' ? '1.5em' : '1.6em',
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
          fontSize: localeIs('ka') ? '1.5em' : '1.6em',
          color: color
        }
      },
      options
    );
  }

  return exports;
})();
