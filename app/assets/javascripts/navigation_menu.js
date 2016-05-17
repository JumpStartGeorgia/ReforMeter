function setup_navigation_menu() {
  $('.js-toggle-navigation').click(function() {
    $('.js-act-as-navigation').toggleClass('is-hidden-on-mobile');
  });
}

$(document).ready(function() {
  setup_navigation_menu();
});
