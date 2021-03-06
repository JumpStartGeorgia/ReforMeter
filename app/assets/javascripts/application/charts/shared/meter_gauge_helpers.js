/*
  The following elements are built according to the size variable:
  - pane size
  - plot band labels (position and size)
  - dial base width
  - label score font size
*/

function meterGaugeHelpers(size, options, chartData) {
  var meterGauge = {};

  if (!chartData) chartData = {};

  meterGauge.chartWidth = size * 1.125;
  meterGauge.chartHeight = size * 1.1;
  meterGauge.paneSize = size;

  meterGauge.min = chartData.min ? chartData.min : 0;
  meterGauge.max = chartData.max ? chartData.max : 10;

  minMaxRange = meterGauge.max - meterGauge.min;

  meterGauge.plotBandRanges = [
    meterGauge.min,
    (minMaxRange * 1/3) + meterGauge.min,
    (minMaxRange * 2/3) + meterGauge.min,
    meterGauge.max
  ];

  meterGauge.plotBandLabelForScore = function(score, texts) {
    if (texts === null) return null;

    texts = texts ? texts : [
      gon.translations.meter_gauge.plot_band_label.behind,
      gon.translations.meter_gauge.plot_band_label.on_track,
      gon.translations.meter_gauge.plot_band_label.ahead
    ];

    var plotBandLabel;

    if (score >= meterGauge.plotBandRanges[0] && score <= meterGauge.plotBandRanges[1]) {
      plotBandLabel = texts[0];
    } else if (score > meterGauge.plotBandRanges[1] && score <= meterGauge.plotBandRanges[2]) {
      plotBandLabel = texts[1];
    } else if (score > meterGauge.plotBandRanges[2] && score <= meterGauge.plotBandRanges[3]) {
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
    function plotBandLabels(texts, options) {
      if (!options) options = {};

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

        if (size < 300) {

          textSpecificProperties = [
            {
              x: meterGauge.textPosition(.205),
              y: meterGauge.textPosition(.305),
              style: {
                fontSize: meterGauge.textSize(1.6)
              }
            },
            {
              x: meterGauge.textPosition(.41),
              y: meterGauge.textPosition(.07),
              style: {
                fontSize: meterGauge.textSize(1.6)
              }
            },
            {
              x: meterGauge.textPosition(.805),
              y: meterGauge.textPosition(.175),
              style: {
                fontSize: meterGauge.textSize(1.6)
              }
            }
          ];

        } else {

          textSpecificProperties = [
            {
              x: meterGauge.textPosition(.215),
              y: meterGauge.textPosition(.26),
              style: {
                fontSize: meterGauge.textSize(1.2),
                fontWeight: 600
              }
            },
            {
              x: meterGauge.textPosition(.44),
              y: meterGauge.textPosition(.1),
              style: {
                fontSize: meterGauge.textSize(1.2),
                fontWeight: 600
              }
            },
            {
              x: meterGauge.textPosition(.825),
              y: meterGauge.textPosition(.195),
              style: {
                fontSize: meterGauge.textSize(1.2),
                fontWeight: 600
              }
            }
          ];

        }

      } else if (arraysEqual(texts, georgianDefaultText)) {

        if (size < 300) {

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

        } else {

          textSpecificProperties = [
            {
              x: meterGauge.textPosition(.225),
              y: meterGauge.textPosition(.26),
              style: {
                fontSize: meterGauge.textSize(1.2),
              }
            },
            {
              x: meterGauge.textPosition(.435),
              y: meterGauge.textPosition(.11),
              style: {
                fontSize: meterGauge.textSize(1.2),
              }
            },
            {
              x: meterGauge.textPosition(.8),
              y: meterGauge.textPosition(.175),
              style: {
                fontSize: meterGauge.textSize(1.2),
              }
            }
          ];

        }

      } else if (arraysEqual(texts, ['Poor', 'Fair', 'Good'])) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.235),
            y: meterGauge.textPosition(.205),
            style: {
              fontSize: meterGauge.textSize(1.8),
            }
          },
          {
            x: meterGauge.textPosition(.5),
            y: meterGauge.textPosition(.02),
            style: {
              fontSize: meterGauge.textSize(1.8),
            }
          },
          {
            x: meterGauge.textPosition(.79),
            y: meterGauge.textPosition(0.09),
            style: {
              fontSize: meterGauge.textSize(1.8),
            }
          }
        ];

      } else if (arraysEqual(texts, ['ცუდი', 'საშუალო', 'კარგი'])) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.195),
            y: meterGauge.textPosition(.205),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          },
          {
            x: meterGauge.textPosition(.39),
            y: meterGauge.textPosition(-.01),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          },
          {
            x: meterGauge.textPosition(.82),
            y: meterGauge.textPosition(0.06),
            style: {
              fontSize: meterGauge.textSize(1.6),
            }
          }
        ];

      } else if (arraysEqual(texts, ['Negative', 'Neutral', 'Positive'])) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.19),
            y: meterGauge.textPosition(.25),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.44),
            y: meterGauge.textPosition(.01),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          },
          {
            x: meterGauge.textPosition(.79),
            y: meterGauge.textPosition(.08),
            style: {
              fontSize: meterGauge.textSize(1.5),
            }
          }
        ];

      } else if (arraysEqual(texts, ['უარყოფითი', 'საშუალო', 'დადებითი'])) {

        textSpecificProperties = [
          {
            x: meterGauge.textPosition(.135),
            y: meterGauge.textPosition(.285),
            style: {
              fontSize: meterGauge.textSize(1.4),
            }
          },
          {
            x: meterGauge.textPosition(.42),
            y: meterGauge.textPosition(-.03),
            style: {
              fontSize: meterGauge.textSize(1.4),
            }
          },
          {
            x: meterGauge.textPosition(.81),
            y: meterGauge.textPosition(0.01),
            style: {
              fontSize: meterGauge.textSize(1.4),
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
