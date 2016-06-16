function highchartDownloadIcon() {
  if (!gon.chart_download_icon) {
    throw new Error('Chart download icon not available');
  }

  return 'url(' + gon.chart_download_icon + ')';
}
