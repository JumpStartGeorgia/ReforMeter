function meterGaugeHelpers(size) {
  var meterGauge = {};

  // For size = 200, proportion = .5 ---> 100
  meterGauge.textPosition = function(proportion) {
    return proportion * size;
  }

  // For size = 200, modifier = 10 ---> 10em
  // For size = 400, modifier = 3 ---> 6em
  meterGauge.textSize = function(modifier) {
    return String(modifier * size/200) + 'em';
  }

  meterGauge.plotBandLabels = function() {
    var exports = {},
        color = 'white';

    exports.behind = function(chartData, options) {
      if (!options) options = {};

      return mergeObjects(
        {
          text: chartData.translations.behind,
          rotation: -60,
          x: meterGauge.textPosition(.275),
          y: localeIs('ka') ? meterGauge.textPosition(.275) : meterGauge.textPosition(.3),
          style: {
            fontSize: gon.locale === 'ka' ? meterGauge.textSize(1.5) : meterGauge.textSize(1.6),
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
          x: meterGauge.textPosition(.47),
          y: meterGauge.textPosition(.07),
          style: {
            fontSize: gon.locale === 'ka' ? meterGauge.textSize(1.5) : meterGauge.textSize(1.6),
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
          x: localeIs('ka') ? meterGauge.textPosition(.85) : meterGauge.textPosition(.865),
          y: localeIs('ka') ? meterGauge.textPosition(.125) : meterGauge.textPosition(.175),
          style: {
            fontSize: localeIs('ka') ? meterGauge.textSize(1.5) : meterGauge.textSize(1.6),
            color: color
          }
        },
        options
      );
    }

    return exports;
  }

  return meterGauge;
}
