function setupAccordions() {
  var accordionSelector = '.js-accordion';
  var accordionToggleButtonSelector = '.js-accordion-toggle-button';
  var accordionTogglableContentSelector = '.js-accordion-togglable-content';

  $(accordionToggleButtonSelector).click(function() {
    $(this)
    .parents(accordionSelector)
    .toggleClass('is-expanded')
    .children(accordionTogglableContentSelector)
    .slideToggle()
  })
}
