function setupExpertTimePeriodSelect() {
  $('input#reform_color_hex').on('change', function(e) {

    $('.js-color-viewer').css('background-color', $(this).val());
  });
}


