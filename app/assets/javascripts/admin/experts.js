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


// update the sort order of the expert
function setupExpertMove(){

  function saveExpertMove(url){
    $.ajax
     ({
        url: url,
        type: "POST",
        dataType: 'json'
     });
  }

  function moveExpertRow(row, direction){
    var $rows = row.closest('tbody').find('tr');

    if ($rows.length > 0){
      var index = $rows.index(row);

      if (index != -1){
        if (direction == 'up' && index > 0 ){
          row.insertBefore($rows[index-1]);
        }else if (direction == 'down' && index < $rows.length){
          row.insertAfter($rows[index+1]);
        }        
      }
    }
  }

  $('table.table-experts').on('click', '.move-up', function(){
    saveExpertMove($(this).data('url'));
    moveExpertRow($(this).closest('tr'), 'up');

    return false;
  });

  $('table.table-experts').on('click', '.move-down', function(){
    saveExpertMove($(this).data('url'));
    moveExpertRow($(this).closest('tr'), 'down');

    return false;
  });

}
