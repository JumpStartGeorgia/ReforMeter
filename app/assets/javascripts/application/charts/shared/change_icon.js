function change_icon(change_number, options) {
  if (!gon.change_icons) {
    throw new Error('Change icons not available');
  }

  if (!options) options = {};

  var icon = gon.change_icons[change_number];

  if (options.modClass) {
    icon = $(icon).addClass(options.modClass)[0].outerHTML;
  }

  return icon;
}
