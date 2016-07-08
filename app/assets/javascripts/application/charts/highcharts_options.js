function setupDefaultOptions() {
  Highcharts.setOptions({
    chart: {
      style: {
        fontSize: '10px'
      }
    },
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
          symbol: highchartDownloadIcon(),
          theme: {
            states: {
              hover: {
                stroke: null
              }
            }
          }
        }
      },
      chartOptions: {
        chart: {
          style: {
            fontFamily: 'sans-serif',
            fontSize: '9px'
          }
        },
        legend: {
          itemDistance: 70,
          x: -40
        }
      },
      enabled: false,
      scale: 1
    },
    yAxis: {
      title: {
        text: null,
        style: {
          fontSize: '1.2em'
        }
      }
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
      return highchartsSmallMeterGaugeOptions(chartData);
    }

    case 'big-meter-gauge': {
      return highchartsBigMeterGaugeOptions(chartData);
    }

    case 'homepage-meter-gauge': {
      return highchartsHomepageMeterGaugeOptions(chartData);
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
