function change_icon(change_number) {
  if (!gon.change_icons) {
    return null;
  }

  return gon.change_icons[change_number]
}
