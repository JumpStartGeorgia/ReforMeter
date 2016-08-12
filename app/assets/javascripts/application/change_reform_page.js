function initializeChangeReformPageControls() {
  var reforms_quarters = gon.linked_reforms_quarters;
  var exports = {};

  var $quarterSelect = $('.js-reform-page-quarter-select');
  var $reformSelect = $('.js-reform-page-reform-select');
  var $loadNewReformButton = $('.js-load-new-reform-page');

  function loadNewReform() {
    var newQuarter = $quarterSelect.val();
    var newReform = $reformSelect.val();
    var newURL = $(this).data('newUrlBase') + '/' + newReform + '/' + newQuarter;

    window.location.href = newURL;
  }

  function updateQuarters() {
    var $quarterOptions = $quarterSelect.find('option');
    var $selectedQuarter = $quarterSelect.find(':selected')
    $quarterOptions.prop('disabled', true);

    function quarterIsAllowed() {
      var quarterOption = this;

      return reforms_quarters.filter(
        function(reformQuarterPair) {
          var stuff = reformQuarterPair.reform_slug === $reformSelect.val() && reformQuarterPair.quarter_slug === quarterOption.value;
          return stuff;
        }
      ).length > 0;
    }

    var $allowedQuarterOptions = $quarterOptions.filter(quarterIsAllowed);

    $allowedQuarterOptions.prop('disabled', false);

    if ($selectedQuarter.prop('disabled')) {
      $selectedQuarter.prop('selected', false);
      $newSelectedQuarter = $quarterSelect.find('option:enabled').first();
      $newSelectedQuarter.prop('selected', true);
    }

    $quarterSelect.select2();
  }

  exports.setup = function() {
    $reformSelect.change(function() {
      updateQuarters();
    });

    $loadNewReformButton.click(loadNewReform);
  }

  return exports;
}
