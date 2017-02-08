function initializeReformVerdictPairs() {
  var exports = {};

  var reforms_verdicts = gon.linked_reforms_verdicts;

  exports.containsPair = function(reform, verdict) {
    return reforms_verdicts.filter(
      function(reformVerdictPair) {
        var reform_matches = reformVerdictPair.reform_slug === reform;
        var verdict_matches = reformVerdictPair.verdict_slug === verdict;
        return reform_matches && verdict_matches;
      }
    ).length > 0;
  }

  return exports;
}

function initializeLoadNewReformButton(reformSelect, verdictSelect) {
  var loadNewReformButton = {};
  var $loadNewReformButton = $('.js-load-new-reform-page');

  loadNewReformButton.setup = function() {
    function loadNewReform() {
      var newVerdict = verdictSelect.jQueryObject.val();
      var newReform = reformSelect.jQueryObject.val();
      var newURL = $loadNewReformButton.data('newUrlBase') + '/' + newReform + '/' + newVerdict;

      window.location.href = newURL;
    }

    $loadNewReformButton.click(loadNewReform);
  }

  return loadNewReformButton;
}

function initializeChangeReformPageControls() {
  var exports = {};
  var reformVerdictPairs = initializeReformVerdictPairs();


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

    reformSelect.setup = function($verdictSelect) {
      var updateVerdicts = selectUpdater(
        $verdictSelect,
        function() {
          return reformVerdictPairs.containsPair(
            $reformSelect.val(),
            this.value
          );
        }
      );

      $reformSelect.change(function() {
        updateVerdicts();
      });

      updateVerdicts();
    }

    return reformSelect;
  }

  function initializeVerdictSelect() {
    var verdictSelect = {};
    var $verdictSelect = $('.js-reform-page-verdict-select');

    Object.defineProperty(
      verdictSelect,
      'jQueryObject',
      {
        get: function() {
          return $verdictSelect;
        }
      }
    );

    verdictSelect.setup = function($reformSelect) {
      var updateReforms = selectUpdater(
        $reformSelect,
        function() {
          return reformVerdictPairs.containsPair(
            this.value,
            $verdictSelect.val()
          );
        }
      );

      $verdictSelect.change(function() {
        updateReforms();
      });

      updateReforms();
    }

    return verdictSelect;
  }

  var verdictSelect = initializeVerdictSelect();
  var reformSelect = initializeReformSelect();

  exports.setup = function() {
    reformSelect.setup(verdictSelect.jQueryObject);
    verdictSelect.setup(reformSelect.jQueryObject);
    initializeLoadNewReformButton(reformSelect, verdictSelect).setup();
  }

  return exports;
}
