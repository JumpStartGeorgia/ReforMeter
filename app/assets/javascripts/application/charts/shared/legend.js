function getHighchartsLegend(chartData) {
  return {
    enabled: chartData.series.length > 1,
    align: 'right',
    symbolWidth: 40,
    itemMarginTop: 10,
    itemStyle: {
      fontWeight: '400'
    }
  }
}
