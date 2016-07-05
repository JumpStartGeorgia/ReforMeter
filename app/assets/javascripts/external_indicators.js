//= require jquery-ui/sortable

  function setTabDisplay(id, status){
    $('.js-optional-' + id).css('display', status);
  }

// update the sort order to be the index values
function updateTableIndex(tables){
  $(tables).each(function(){
    $(this).find('tr').each(function(index){
      $(this).find('td.js-has-sort-order input.sort-order').val(index);
    });
  });
}

// move a row in other tables to match the row that was just moved
function moveRowInOtherTables(current_tab_pane, original_index, move_direction){
  var $tab_panes = current_tab_pane.closest('.js-optional').find('.tab-pane');
  var original_locale = current_tab_pane.data('locale');

  // update the table in each tab pane
  $tab_panes.each(function(){
    // if the tab pane is not the original locale that already had the row moved, move it
    if ($(this).data('locale') != original_locale){
      var $rows = $(this).find('table tbody tr');
      var $row_to_move = $(this).find('table tbody tr:eq(' + original_index + ')');
      if ($row_to_move.length > 0){
        if (move_direction == 'up'){
          $row_to_move.insertBefore($rows[original_index-1]);
        }else{
          $row_to_move.insertAfter($rows[original_index+1]);
        }
      }
    }
  });
}


  function setExternalIndicatorTabDisplay(){
    var val = $('input[name="external_indicator[indicator_type]"]:checked').val();
    // 1 = basic
    // 2 = country
    // 3 = composite
    if (val == '2'){
      setTabDisplay('countries', 'block');
      setTabDisplay('indices', 'none');
    }else if (val == '3'){
      setTabDisplay('countries', 'none');
      setTabDisplay('indices', 'block');
    }else {
      setTabDisplay('countries', 'none');
      setTabDisplay('indices', 'none');
    }
  }


function setupExternalIndicatorType() {

  $('input[name="external_indicator[indicator_type]"]').click(function() {
    setExternalIndicatorTabDisplay()
  });

  // when form loads, if indicator_type is set, show the correct tabs
  $(document).ready(function() {
    setExternalIndicatorTabDisplay();
  });
}

function setupExternalIndicatorCocoon(){
  // add country
  $('.js-optional-countries .tab-pane').on('cocoon:after-insert', function(e, insertedItem) {
    var locale = $(this).data('locale');
    var page_locales = [];
    var row = $(insertedItem).clone();

    // get all locales except the active one
    $('.js-optional-countries .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // replace the locale and then add the row to the correct table
    for(var i=0;i<page_locales.length;i++){
      // update the inserted row with the appropriate locale
      $(row).html($(row).html().replace(new RegExp("_" + locale,"g"), '_' + page_locales[i]));
      // add the row
      $('.js-optional-countries .tab-pane[data-locale="' + page_locales[i] + '"] table tbody').append($(row));
    }

    // update the row indices
    updateTableIndex($(this).closest('.js-optional').find('.tab-pane table tbody'));
  });

  // delete country
  $('.js-optional-countries .tab-pane').on('cocoon:before-remove', function(e, deletedItem) {
    // get the index of the row being deleted so the same row for other languages can also be deleted
    var index = $(this).find('table tbody tr').index(deletedItem);

    // mark this row in every table as deleted
    $('.js-optional-countries .tab-pane table tbody').each(function(){
      var row = $(this).find('tr')[index];
      // mark as deleted
      $(row).find('td:last input').val('true');
      // hide row
      $(row).fadeOut();
    });

  });

  // add index
  $('.js-optional-indices .tab-pane').on('cocoon:after-insert', function(e, insertedItem) {
    var locale = $(this).data('locale');
    var page_locales = [];
    var row = $(insertedItem).clone();

    // get all locales except the active one
    $('.js-optional-indices .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // replace the locale and then add the row to the correct table
    for(var i=0;i<page_locales.length;i++){
      // update the inserted row with the appropriate locale
      $(row).html($(row).html().replace(new RegExp("_" + locale,"g"), '_' + page_locales[i]));
      // add the row
      $('.js-optional-indices .tab-pane[data-locale="' + page_locales[i] + '"] table tbody').append($(row));
    }

    // update the row indices
    updateTableIndex($(this).closest('.js-optional').find('.tab-pane table tbody'));
  });

  // delete index
  $('.js-optional-indices .tab-pane').on('cocoon:before-remove', function(e, deletedItem) {
    // get the index of the row being deleted so the same row for other languages can also be deleted
    var index = $(this).find('table tbody tr').index(deletedItem);

    // mark this row in every table as deleted
    $('.js-optional-indices .tab-pane table tbody').each(function(){
      var row = $(this).find('tr')[index];
      // mark as deleted
      $(row).find('td:last input').val('true');
      // hide row
      $(row).fadeOut();
    });
  });
}


// move country/index rows up and down to change order
function setupExternalIndicatorMove(){

  $('tr.nested-fields a.move-up').on('click', function(){
    var $row = $(this).closest('tr');

    // cannot use jquery next for cocoon puts hidden fields in between
    // tr tags, so have to look for next by hand
    var $rows = $row.closest('tbody').find('tr');
    var index = $rows.index($row);
    if (index > 0){
      $row.insertBefore($rows[index-1]);
    }


    // make the same movement in the other tables
    moveRowInOtherTables($row.closest('.tab-pane'), index, 'up');

    // update the row indices
    updateTableIndex($(this).closest('.js-optional').find('.tab-pane table tbody'));

    return false;
  });

  $('tr.nested-fields a.move-down').on('click', function(){
    var $row = $(this).closest('tr');

    // cannot use jquery next for cocoon puts hidden fields in between
    // tr tags, so have to look for next by hand
    var $rows = $row.closest('tbody').find('tr');
    var index = $rows.index($row);
    if (index < $rows.length-1){
      $row.insertAfter($rows[index+1]);
    }

    // make the same movement in the other tables
    moveRowInOtherTables($row.closest('.tab-pane'), index, 'down');

    // update the row indices
    updateTableIndex($(this).closest('.js-optional').find('.tab-pane table tbody'));

    return false;
  });

}