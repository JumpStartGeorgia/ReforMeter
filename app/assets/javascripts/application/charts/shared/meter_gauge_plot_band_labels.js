var meterGaugePlotBandLabels = {
  onTrack: function(chartData, options) {
    return mergeObjects(
      {
        text: chartData.translations.on_track,
        x: 88,
        y: 20,
        style: {
          fontSize: gon.locale === 'ka' ? '17px' : '18px',
          color: 'white'
        }
      },
      options
    );
  }
}
