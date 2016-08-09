function change_icon(change_number) {
  if (!gon.change_icons) {
    throw new Error('Change icons not available');
  }

  var icon = gon.change_icons[change_number];

  return icon;
}
