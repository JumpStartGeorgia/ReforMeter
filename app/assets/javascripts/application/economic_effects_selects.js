function initializeChangeEconomicEffectsControls() {
	var exports = {};
	var $selector = $('.js-filter-reform');

	function filter_economic_effects() {
		var selectedFilter = $selector.val();
		if(selectedFilter == 'default') {
			$('.contentSection.external-indicator').show();
			$('.economic-effects-select option').show();
		} else {
			var $econ_ef_select = $('.economic-effects-select');
			$('.contentSection.external-indicator').hide();
			$( '.contentSection.external-indicator.'+selectedFilter).show();
			// $( '.contentSection.external-indicator.'+selectedFilter).each(function() {
			//   $(this).show();
			//   $econ_ef_select.find('#' + $(this).attr('id')).show();
			// });
		}
	}

	exports.setup = function() {
	  $selector.change(filter_economic_effects);
	}

	return exports;
}