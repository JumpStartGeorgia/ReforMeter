// Shows and hides the loading indicator when users switch pages

$(document).on("page:before-change", function() {
  $(".loadingIndicator").fadeIn();
});

$(document).on("page:change", function() {
  $(".loadingIndicator").fadeOut();
});
