function setupAccordions() {
  var accordionSelector = '.js-accordion';
  var accordionToggleButtonSelector = '.js-accordion-toggle-button';
  var accordionTogglableContentSelector = '.js-accordion-togglable-content';

  function hideContentIfHidden() {
    $(accordionSelector).each(function() {
      var $accordion = $(this);

      if (!$accordion.hasClass('is-expanded')) {
        $accordion
        .children(accordionTogglableContentSelector)
        .hide();
      }
    })
  }

  function slideToggleContent() {
    $(this)
    .parents(accordionSelector)
    .toggleClass('is-expanded')
    .children(accordionTogglableContentSelector)
    .slideToggle();
  }

  hideContentIfHidden();

  $(accordionToggleButtonSelector).click(slideToggleContent)
}
