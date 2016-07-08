/*
  The following elements are built according to the size variable:
  - pane size
  - plot band labels (position and size)
  - dial base width
  - label score font size
*/

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
          y: localeIs('ka') ? meterGauge.textPosition(.275) : meterGauge.textPosition(.28),
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

  meterGauge.dataLabel = function(chartData, point, fontSize, args) {
    if (!args) args = {};

    var unit = args.unit;
    if (!unit) unit = '';

    var color = args.color;
    if (!color) color = 'black';

    function inDiv(content) {
      return '<div style="text-align:center;">' + content + '</div>';
    }
    var score = '<span style="font-size:' + fontSize + ';color:' + color + ';">' + point.y + unit + '</span>';

    if (chartData.change === null) {
      return inDiv(score);
    } else {
      var icon = change_icon(chartData.change);
      var iconInSpan = '<span style="width: ' + fontSize + ';height: ' + fontSize + ';display: inline-block;">' + icon + '</span>';

      return inDiv(score + iconInSpan);
    }
  }

  return meterGauge;
}
