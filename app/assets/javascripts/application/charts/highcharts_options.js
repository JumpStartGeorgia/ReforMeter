// plotBands is array of plot bands from chartData
// create settings for each plot band
function plotBands(plotBands, use_opacity) {
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


function setupDefaultOptions() {
  Highcharts.setOptions({
    credits: false,
    exporting: {
      buttons: {
        contextButton: {
          menuItems: [
            {
              text: gon.chart_download.translations.download_png,
              onclick: function() {
                this.exportChart();
              }
            },
            {
              text: gon.chart_download.translations.download_jpeg,
              onclick: function() {
                this.exportChart(
                  {
                    type: 'image/jpeg'
                  }
                );
              }
            },
            {
              text: gon.chart_download.translations.download_pdf,
              onclick: function() {
                this.exportChart(
                  {
                    type: 'application/pdf'
                  }
                );
              }
            },
            {
              text: gon.chart_download.translations.download_svg,
              onclick: function() {
                this.exportChart(
                  {
                    type: 'image/svg+xml'
                  }
                );
              }
            }
          ],
          symbol: highchartDownloadIcon()
        }
      },
      enabled: false
    },
    yAxis: {
      title: false
    }
  });
}

function highchartsOptions(chartType, chartData) {
  switch (chartType) {

    case 'rating-history-time-series': {
      return ratingHistoryTimeSeriesOptions(chartData);
    }

    case 'small-rating-history-time-series': {
      return smallRatingHistoryTimeSeriesOptions(chartData);
    }

    case 'percentage-history-time-series': {
      return percentageHistoryTimeSeriesOptions(chartData);
    }

    case 'percentage-colorful-reforms-history-time-series': {
      return percentageColorfulReformsHistoryTimeSeriesOptions(chartData);
    }

    case 'mini-time-series': {
      return miniTimeSeries(chartData);
    }

    case 'small-meter-gauge': {
      return Highcharts.merge(
        highchartsMeterGaugeOptions(chartData),
        highchartsSmallMeterGaugeOptions(chartData)
      );
    }

    case 'big-meter-gauge': {
      return Highcharts.merge(
        highchartsMeterGaugeOptions(chartData),
        highchartsBigMeterGaugeOptions(chartData)
      );
    }

    case 'homepage-meter-gauge': {
      return Highcharts.merge(
        highchartsMeterGaugeOptions(chartData),
        highchartsHomepageMeterGaugeOptions(chartData)
      );
    }

    case 'big-solid-gauge': {
      return highchartsBigSolidGaugeOptions(chartData);
    }

    case 'small-solid-gauge': {
      return highchartsSmallSolidGaugeOptions(chartData);
    }

    case 'external-indicator-area-time-series': {
      return highchartsExternalIndicatorAreaTimeSeries(chartData);
    }

    case 'external-indicator-bar': {
      return highchartsExternalIndicatorBar(chartData);
    }

    case 'external-indicator-line-time-series': {
      return highchartsExternalIndicatorLineTimeSeries(chartData);
    }
  }
}
