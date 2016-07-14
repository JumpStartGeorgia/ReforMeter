function highchartDownloadIcon() {
  if (!gon.chart_download || !gon.chart_download.icon) {
    throw new Error('Chart download icon not available');
  }

  return 'url(' + gon.chart_download.icon + ')';
}
