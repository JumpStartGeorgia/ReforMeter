/*
  The following elements are built according to the size variable:
  - pane size
  - plot band labels (position and size)
  - dial base width
  - label score font size
*/

function meterGaugeHelpers(size, options) {
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

  // by default uses text Behind, On Track, Ahead
  meterGauge.plotBandLabels = function(texts) {
    var exports = {},
        color = 'white',
        georgianDefaultText = ['სუსტი', 'ზომიერი', 'ძლიერი'],
        englishDefaultText = ['Behind', 'On Track', 'Ahead'];

    // Returns the base properties to position and style certain texts
    // correctly as plot band labels on a meter gauge. Only works for
    // certain texts; will otherwise throw an error.
    function plotBandLabelBases(texts) {
      if (arraysEqual(texts, englishDefaultText)) {

        return [
          {
            text: gon.translations.meter_gauge.plot_band_label.behind,
            rotation: -60,
            x: meterGauge.textPosition(.215),
            y: meterGauge.textPosition(.28),
            style: {
              fontSize: meterGauge.textSize(1.6),
              color: color
            }
          },
          {
            text: gon.translations.meter_gauge.plot_band_label.on_track,
            x: meterGauge.textPosition(.41),
            y: meterGauge.textPosition(.07),
            style: {
              fontSize: meterGauge.textSize(1.6),
              color: color
            }
          },
          {
            text: gon.translations.meter_gauge.plot_band_label.ahead,
            rotation: 60,
            x: meterGauge.textPosition(.805),
            y: meterGauge.textPosition(.175),
            style: {
              fontSize: meterGauge.textSize(1.6),
              color: color
            }
          }
        ];

      } else if (arraysEqual(texts, georgianDefaultText)) {

        return [
          {
            text: gon.translations.meter_gauge.plot_band_label.behind,
            rotation: -60,
            x: meterGauge.textPosition(.215),
            y: meterGauge.textPosition(.275),
            style: {
              fontSize: meterGauge.textSize(1.5),
              color: color
            }
          },
          {
            text: gon.translations.meter_gauge.plot_band_label.on_track,
            x: meterGauge.textPosition(.41),
            y: meterGauge.textPosition(.07),
            style: {
              fontSize: meterGauge.textSize(1.5),
              color: color
            }
          },
          {
            text: gon.translations.meter_gauge.plot_band_label.ahead,
            rotation: 60,
            x: meterGauge.textPosition(.79),
            y: meterGauge.textPosition(.125),
            style: {
              fontSize: meterGauge.textSize(1.5),
              color: color
            }
          }
        ];

      } else {

        throw new Error('No meter gauge plot band label base properties are available for provided plot band text')

      }
    }

    var plotBandLabels;

    if (typeof texts === 'undefined') {
      if (localeIs('ka')) {
        plotBandLabels = plotBandLabelBases(georgianDefaultText);
      } else {
        plotBandLabels = plotBandLabelBases(englishDefaultText);
      }
    } else {
      plotBandLabels = plotBandLabelBases(texts);
    }

    exports.behind = function(chartData, options) {
      if (!options) options = {};

      return mergeObjects(
        plotBandLabels[0],
        options
      );
    }

    exports.onTrack = function(chartData, options) {
      return mergeObjects(
        plotBandLabels[1],
        options
      );
    }

    exports.ahead = function(chartData, options) {
      return mergeObjects(
        plotBandLabels[2],
        options
      );
    }

    return exports;
  }

  return meterGauge;
}
