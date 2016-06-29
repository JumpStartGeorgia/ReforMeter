function setupReformColorSelect() {
  function formatResult (state) {
    if (!state.id) { return state.text; }
    var $state = $(
      '<div style="background-color: ' + $(state.element).data('color') + '; color: #fff; padding: 3px 6px;">' + state.text + '</div>'
    );
    return $state;
  };
  function formatSelection (state) {
    if (!state.id) { return state.text; }
    var $state = $(
      '<div style="background-color: ' + $(state.element).data('color') + '; color: #fff; padding: 0 6px;">' + state.text + '</div>'
    );
    return $state;
  };

  $("select#reform_reform_color_id").select2({
    minimumResultsForSearch: -1, // removes search bar
    templateResult: formatResult,
    templateSelection: formatSelection
  });
}


