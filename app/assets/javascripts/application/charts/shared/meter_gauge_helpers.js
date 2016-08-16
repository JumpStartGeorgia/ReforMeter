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

  meterGauge.plotBandLabelForScore = function(score, texts) {
    texts = texts ? texts : [
      gon.translations.meter_gauge.plot_band_label.behind,
      gon.translations.meter_gauge.plot_band_label.on_track,
      gon.translations.meter_gauge.plot_band_label.ahead
    ];

    var plotBandLabel;

    if (score >= 0 && score <= 3.3) {
      plotBandLabel = texts[0];
    } else if (score > 3.3 && score <= 6.6) {
      plotBandLabel = texts[1];
    } else if (score > 6.6 && score <= 10) {
      plotBandLabel = texts[2];
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

  function PlotBandTextError(message) {
    this.message = message;
    this.stack = (new Error()).stack;
  }

  PlotBandTextError.prototype = Object.create(Error.prototype);
  PlotBandTextError.prototype.name = 'PlotBandTextError';

  // by default uses text Behind, On Track, Ahead
  meterGauge.plotBandLabels = function(texts) {
    var exports = {},
        color = 'white',
        defaultTexts = [
          gon.translations.meter_gauge.plot_band_label.behind,
          gon.translations.meter_gauge.plot_band_label.on_track,
          gon.translations.meter_gauge.plot_band_label.ahead
        ];

    var georgianDefaultText = localeIs('ka') ? defaultTexts : null,
        englishDefaultText = localeIs('en') ? defaultTexts : null;

    // Returns the base properties to position and style certain texts
    // correctly as plot band labels on a meter gauge. Only works for
    // certain texts; will otherwise throw an error.
    function plotBandLabels(texts) {

      // Properties for labels regardless of text
      var plotBandBases = [
        {
          text: texts[0],
          rotation: -60,
          style: {
            color: color
          }
        },
        {
          text: texts[1],
          style: {
            color: color
          }
        },
        {
          text: texts[2],
          rotation: 60,
          style: {
            color: color
          }
        }
      ]

      // Properties for labels that are specific to text
      var textSpecificProperties;

      if (arraysEqual(texts, englishDefaultText)) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.215),
            y: meterGauge.textPosition(.28),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          },
          {
            x: meterGauge.textPosition(.41),
            y: meterGauge.textPosition(.07),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          },
          {
            x: meterGauge.textPosition(.805),
            y: meterGauge.textPosition(.175),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          }
        ];

      } else if (arraysEqual(texts, georgianDefaultText)) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.215),
            y: meterGauge.textPosition(.275),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.41),
            y: meterGauge.textPosition(.07),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.79),
            y: meterGauge.textPosition(.125),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          }
        ];

      } else if (arraysEqual(texts, ['Poor', 'Fair', 'Good'])) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.215),
            y: meterGauge.textPosition(.275),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.51),
            y: meterGauge.textPosition(.2),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.85),
            y: meterGauge.textPosition(.285),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          }
        ];

      } else {

        throw new PlotBandTextError('No meter gauge plot band label base properties are available for provided plot band text')

      }

      // combine general and text-specific label properties
      return plotBandBases.map(function(plotBandBase, index) {
        return $.extend(true, plotBandBase, textSpecificProperties[index])
      });
    }

    var plotBandLabelProperties;

    try {

      if (typeof texts === 'undefined') {
        if (localeIs('ka')) {
          plotBandLabelProperties = plotBandLabels(georgianDefaultText);
        } else {
          plotBandLabelProperties = plotBandLabels(englishDefaultText);
        }
      } else {
        plotBandLabelProperties = plotBandLabels(texts);
      }

    } catch(error) {

      if (error instanceof PlotBandTextError) {
        console.log(error.message);
        return undefined;
      } else {
        throw error;
      }

    }

    exports.behind = function(chartData, options) {
      if (!options) options = {};

      return mergeObjects(
        plotBandLabelProperties[0],
        options
      );
    }

    exports.onTrack = function(chartData, options) {
      return mergeObjects(
        plotBandLabelProperties[1],
        options
      );
    }

    exports.ahead = function(chartData, options) {
      return mergeObjects(
        plotBandLabelProperties[2],
        options
      );
    }

    return exports;
  }

  return meterGauge;
}
