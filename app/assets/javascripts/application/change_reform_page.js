function initializeReformQuarterPairs() {
  var exports = {};

  var reforms_quarters = gon.linked_reforms_quarters;

  exports.containsPair = function(reform, quarter) {
    return reforms_quarters.filter(
      function(reformQuarterPair) {
        var reform_matches = reformQuarterPair.reform_slug === reform;
        var quarter_matches = reformQuarterPair.quarter_slug === quarter;
        return reform_matches && quarter_matches;
      }
    ).length > 0;
  }

  return exports;
}

function initializeLoadNewReformButton(reformSelect, quarterSelect) {
  var loadNewReformButton = {};
  var $loadNewReformButton = $('.js-load-new-reform-page');

  loadNewReformButton.setup = function() {
    function loadNewReform() {
      var newQuarter = quarterSelect.jQueryObject.val();
      var newReform = reformSelect.jQueryObject.val();
      var newURL = $loadNewReformButton.data('newUrlBase') + '/' + newReform + '/' + newQuarter;

      window.location.href = newURL;
    }

    $loadNewReformButton.click(loadNewReform);
  }

  return loadNewReformButton;
}

function initializeChangeReformPageControls() {
  var exports = {};
  var reformQuarterPairs = initializeReformQuarterPairs();


  function selectUpdater($select, allowCondition) {
    return function() {
      var $options = $select.find('option');
      var $selectedOption = $select.find(':selected');
      $options.prop('disabled', true);

      var $allowedOptions = $options.filter(allowCondition);

      $allowedOptions.prop('disabled', false);

      if ($selectedOption.prop('disabled')) {
        $selectedOption.prop('selected', false);
        $newSelectedOption = $select.find('option:enabled').first();
        $newSelectedOption.prop('selected', true);
      }

      $select.select2();
    }
  }

  function initializeReformSelect() {
    var reformSelect = {};
    var $reformSelect = $('.js-reform-page-reform-select');

    Object.defineProperty(
      reformSelect,
      'jQueryObject',
      {
        get: function() {
          return $reformSelect;
        }
      }
    );

    reformSelect.setup = function($quarterSelect) {
      var updateQuarters = selectUpdater(
        $quarterSelect,
        function() {
          return reformQuarterPairs.containsPair(
            $reformSelect.val(),
            this.value
          );
        }
      );

      $reformSelect.change(function() {
        updateQuarters();
      });

      updateQuarters();
    }

    return reformSelect;
  }

  function initializeQuarterSelect() {
    var quarterSelect = {};
    var $quarterSelect = $('.js-reform-page-quarter-select');

    Object.defineProperty(
      quarterSelect,
      'jQueryObject',
      {
        get: function() {
          return $quarterSelect;
        }
      }
    );

    quarterSelect.setup = function($reformSelect) {
      var updateReforms = selectUpdater(
        $reformSelect,
        function() {
          return reformQuarterPairs.containsPair(
            this.value,
            $quarterSelect.val()
          );
        }
      );

      $quarterSelect.change(function() {
        updateReforms();
      });

      updateReforms();
    }

    return quarterSelect;
  }

  var quarterSelect = initializeQuarterSelect();
  var reformSelect = initializeReformSelect();

  exports.setup = function() {
    reformSelect.setup(quarterSelect.jQueryObject);
    quarterSelect.setup(reformSelect.jQueryObject);
    initializeLoadNewReformButton(reformSelect, quarterSelect).setup();
  }

  return exports;
}
