function setupExpertReformSelector() {

  function showExpertReformSelector(){
    // if stakeholder selected, show reform selection
    // else hide it
    if ($('form.expert #expert_expert_type_input input[name="expert[expert_type]"]:checked').val() == '2'){
      $('form.expert #expert_reform_id_input').show();
    }else{
      $('form.expert #expert_reform_id_input').hide();
    }
  }

  $('form.expert #expert_expert_type_input').on('change', 'input', function(){
    showExpertReformSelector();
  });

  // set it when the page loads
  showExpertReformSelector();
}


