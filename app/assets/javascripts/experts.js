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

function openExpertsTab() {
  var anchor_tag = window.location.hash.substring(1);

  var expertElement = $('#' + anchor_tag);

  // return if the anchor tag is not found among listed expert ids on page
  if (expertElement.length === 0) return false;

  $('.js-act-as-tab-list-button[data-selects-tab-content-panel-id="experts"]').click();

  return true;
}
