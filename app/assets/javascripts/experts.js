function setupExpertsSelectAll() {
  $('.js-expects-select-all').on('click', function(e) {
    if ($(this).data('state') == 'none'){
      $('#expert_survey_experts_input input[type="checkbox"]').prop('checked', false);
    }else{
      $('#expert_survey_experts_input input[type="checkbox"]').prop('checked', true);
    }
    return false;
  });
}
