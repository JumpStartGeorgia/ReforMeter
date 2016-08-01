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
    setExternalIndicatorTabDisplay();
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

  // add plot band
  $('.js-optional-plot-bands .tab-pane').on('cocoon:after-insert', function(e, insertedItem) {
    var locale = $(this).data('locale');
    var page_locales = [];
    var row = $(insertedItem).clone();

    // get all locales except the active one
    $('.js-optional-plot-bands .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // replace the locale and then add the row to the correct table
    for(var i=0;i<page_locales.length;i++){
      // update the inserted row with the appropriate locale
      $(row).html($(row).html().replace(new RegExp("_" + locale,"g"), '_' + page_locales[i]));

      // add the row
      $('.js-optional-plot-bands .tab-pane[data-locale="' + page_locales[i] + '"] table tbody').append($(row));
    }


    // if the new row is not in default locale tab, remove the input fields for to/from
    // including the the locale that started the cocoon insert because it might not need to have the inputs since the add button is in all tabs
    page_locales.push(locale);
    for(var i=0;i<page_locales.length;i++){
      if (page_locales[i] != gon.default_locale){
        $('.js-optional-plot-bands .tab-pane[data-locale="' + page_locales[i] + '"] table tbody tr:last td.js-to-clear').html('');
      }
    }

  });

  // delete plot band
  $('.js-optional-plot-bands .tab-pane').on('cocoon:before-remove', function(e, deletedItem) {
    // get the index of the row being deleted so the same row for other languages can also be deleted
    var index = $(this).find('table tbody tr').index(deletedItem);

    // mark this row in every table as deleted
    $('.js-optional-plot-bands .tab-pane table tbody').each(function(){
      var row = $(this).find('tr')[index];
      // mark as deleted
      $(row).find('td:last input').val('true');
      // hide row
      $(row).fadeOut();
    });

  });


  // when the from value changes, update this value in all other tables
  $('.js-optional-plot-bands .tab-pane').on('change', '.js-update-value', function(){
    var locale = $(this).closest('.tab-pane').data('locale');
    // due to cocoon putting hidden fields between tr, cannot do simple tr.index(), so have to look by hand
    var td = $(this).closest('td');
    var tr = $(this).closest('tr');
    var row_index = $(this).closest('tbody').find('tr').index(tr);
    var col_index = $(this).closest('tr').find('td').index(td);
    var page_locales = [];

    // get all locales except the active one
    $('.js-optional-plot-bands .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});
    // update the value
    for(var i=0;i<page_locales.length;i++){
      $('.js-optional-plot-bands .tab-pane[data-locale="' + page_locales[i] + '"] table tbody tr:eq(' + row_index + ') td:eq(' + col_index + ')').html($(this).val());
    }
  });




  // add data row
  $('.js-optional-time-periods .tab-pane').on('cocoon:after-insert', function(e, insertedItem) {
    var locale = $(this).data('locale');
    var page_locales = [];
    var row = $(insertedItem).clone();

    // get all locales except the active one
    $('.js-optional-time-periods .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // replace the locale and then add the row to the correct table
    for(var i=0;i<page_locales.length;i++){
      // update the inserted row with the appropriate locale
      $(row).html($(row).html().replace(new RegExp("_" + locale,"g"), '_' + page_locales[i]));

      // add the row
      $('.js-optional-time-periods .tab-pane[data-locale="' + page_locales[i] + '"] table tbody').append($(row));
    }


    // if the new row is not in default locale tab, remove the input fields for to/from
    // including the the locale that started the cocoon insert because it might not need to have the inputs since the add button is in all tabs
    page_locales.push(locale);
    for(var i=0;i<page_locales.length;i++){
      if (page_locales[i] != gon.default_locale){
        $('.js-optional-time-periods .tab-pane[data-locale="' + page_locales[i] + '"] table tbody tr:last td.js-to-clear').html('');
      }
    }

  });

  // delete data row
  $('.js-optional-time-periods .tab-pane').on('cocoon:before-remove', function(e, deletedItem) {
    // get the index of the row being deleted so the same row for other languages can also be deleted
    var index = $(this).find('table tbody tr').index(deletedItem);

    // mark this row in every table as deleted
    $('.js-optional-time-periods .tab-pane table tbody').each(function(){
      var row = $(this).find('tr')[index];
      // mark as deleted
      $(row).find('td:last input').val('true');
      // hide row
      $(row).fadeOut();
    });

  });


  // when the from value changes, update this value in all other tables
  $('.js-optional-time-periods .tab-pane').on('change', '.js-update-value', function(){
    var locale = $(this).closest('.tab-pane').data('locale');
    // due to cocoon putting hidden fields between tr, cannot do simple tr.index(), so have to look by hand
    var td = $(this).closest('td');
    var tr = $(this).closest('tr');
    var row_index = $(this).closest('tbody').find('tr').index(tr);
    var col_index = $(this).closest('tr').find('td').index(td);
    var page_locales = [];

    // get all locales except the active one
    $('.js-optional-time-periods .tab-pane').each(function(){if ($(this).data('locale') != locale){page_locales.push($(this).data('locale'))}});

    // update the value
    for(var i=0;i<page_locales.length;i++){
      $('.js-optional-time-periods .tab-pane[data-locale="' + page_locales[i] + '"] table tbody tr:eq(' + row_index + ') td:eq(' + col_index + ')').html($(this).val());
    }
  });

}


// move table rows up and down to change order
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