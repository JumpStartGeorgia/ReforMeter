function getHighchartsLegend(chartData) {
  return {
    enabled: chartData.series.length > 1,
    align: 'right',
    symbolWidth: 40,
    // Adding itemMarginTop increases the vertical margin between items in
    // the legend when they wrap. However, it also messes up the way
    // the legend items are used in the tooltip, which requires some
    // SVG hacks to fix that were not worth it.
    // itemMarginTop: 10,
    itemStyle: {
      fontWeight: '400'
    }
  }
}
