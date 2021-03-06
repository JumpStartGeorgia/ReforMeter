function postCreateChartImages(charts, exportType) {

  charts.forEach(function(chart) {
    var pngImagePath = chart.png_image_path;

    if (typeof pngImagePath !== 'string') return false;

    $.post(
      gon.create_chart_share_image_url,
      {
        png_image_path: pngImagePath,
        highcharts_export_options: chart.getExportOptions(exportType)
      }
    );

  });

}
