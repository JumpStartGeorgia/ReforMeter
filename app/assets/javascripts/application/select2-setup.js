function setupSelect2() {
  function initialize() {
    var methods = {};

    var options = {
      width: 'auto',
      minimumResultsForSearch: -1, // removes search bar
      dropdownAutoWidth : true
    };

    var $select2 = $('.js-become-select2').select2(options);

    methods.addClassToDropdown = function() {
      $select2.each(function() {
        var dropdownClass = $(this).data('dropdown-class');
        $(this).data('select2').$dropdown.addClass(dropdownClass);
      });
    }

    return methods;
  }

  var select2 = initialize();
  select2.addClassToDropdown();
}
