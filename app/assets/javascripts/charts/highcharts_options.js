function chartColors() {
  return ['#1599D6', '#2DB9EA', '#5AD7F9']
}

function highchartsOptions(chartType, chartData) {
  switch (chartType) {

    case 'rating-history-time-series': {
      return ratingHistoryTimeSeriesOptions(chartData);
    }

    case 'percentage-history-time-series': {
      return percentageHistoryTimeSeriesOptions(chartData);
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

    case 'big-solid-gauge': {
      return highchartsBigSolidGaugeOptions(chartData);
    }

    case 'small-solid-gauge': {
      return highchartsSmallSolidGaugeOptions(chartData);
    }
  }
}
