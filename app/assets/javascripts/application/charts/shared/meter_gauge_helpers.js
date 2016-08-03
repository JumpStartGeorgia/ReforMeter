/*
  The following elements are built according to the size variable:
  - pane size
  - plot band labels (position and size)
  - dial base width
  - label score font size
*/

function meterGaugeHelpers(size) {
  var meterGauge = {};

  meterGauge.chartWidth = size * 1.125;
  meterGauge.chartHeight = size * 1.1;
  meterGauge.paneSize = size;
  
  meterGauge.plotBandLabelForScore = function(score) {
    var plotBandLabel;
    
    if (score >= 0 && score <= 3.3) {
      plotBandLabel = gon.translations.meter_gauge.plot_band_label.behind;
    } else if (score > 3.3 && score <= 6.6) {
      plotBandLabel = gon.translations.meter_gauge.plot_band_label.on_track;
    } else if (score > 6.6 && score <= 10) {
      plotBandLabel = gon.translations.meter_gauge.plot_band_label.ahead;
    } else {
      throw new Error('No meter gauge plot band label available for score ' + score)
    }
    
    return plotBandLabel;
  }

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
          text: gon.translations.meter_gauge.plot_band_label.behind,
          rotation: -60,
          x: meterGauge.textPosition(.215),
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
          text: gon.translations.meter_gauge.plot_band_label.on_track,
          x: meterGauge.textPosition(.41),
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
          text: gon.translations.meter_gauge.plot_band_label.ahead,
          rotation: 60,
          x: localeIs('ka') ? meterGauge.textPosition(.79) : meterGauge.textPosition(.805),
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
