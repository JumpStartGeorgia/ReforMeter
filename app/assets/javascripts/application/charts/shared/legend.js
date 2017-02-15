function getHighchartsLegend(chartData) {
  return {
    enabled: chartData.series.length > 1,
    align: 'right',
    symbolWidth: 40,
    itemStyle: {
      fontWeight: '400'
    }
  }
}
