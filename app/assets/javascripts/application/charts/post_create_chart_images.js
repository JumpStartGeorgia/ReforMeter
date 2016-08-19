function postCreateChartImages(charts, exportType) {

  charts.forEach(function(chart) {
    var pngImagePath = chart.data.png_image_path;

    if (!pngImagePath) return false;

    $.post(
      gon.create_chart_share_image_url,
      {
        png_image_path: pngImagePath,
        highcharts_export_options: chart.getExportOptions(exportType)
      }
    );

  });

}
