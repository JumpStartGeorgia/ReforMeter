function initializeChangeEconomicEffectsControls() {
	var exports = {};
	var $selector = $('.js-filter-reform');

	var options = {
      width: 'auto',
      minimumResultsForSearch: -1, // removes search bar
      dropdownAutoWidth : true
    };

	function filter_economic_effects() {
		var selectedFilter = $selector.val();
		var $econ_ef_select = $('.economic-effects-select');
		var dropdown_keyword = 'dropdown';
		if(selectedFilter == 'default') {
			$('.contentSection.external-indicator').show();
			$('.economic-effects-select option').show();
			$econ_ef_select.find('option').prop('disabled', false);
		} else {
			$('.contentSection.external-indicator').hide();
			$econ_ef_select.find('option').not('.default').prop('disabled', true);
			$( '.contentSection.external-indicator.'+selectedFilter).each(function() {
			  $(this).show();
			  $econ_ef_select.find('#' + dropdown_keyword + '-' + $(this).attr('id')).prop('disabled', false);
			});
		}
		$econ_ef_select.select2(options);
	}

	exports.setup = function() {
	  $selector.change(filter_economic_effects);
	  alert();
	}

	return exports;
}