function imageScaleForSVG(svg) {
  var scale = 1;
  var svgWidth = parseInt($(svg).attr('width'));

  // Facebook prefers share images to have 1200px width or higher, so
  // increase the scale to reach that width as necessary.
  var minimumImageWidth = 1200;

  if (svgWidth < minimumImageWidth) scale = minimumImageWidth / svgWidth;

  return scale;
}
