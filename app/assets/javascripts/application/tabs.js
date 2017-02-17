function setupTabs() {
  function unselectSiblingTabListButtons($selectedTabListButton) {
    var $tabList = $selectedTabListButton.parents('.js-act-as-tab-list');
    var $tabListButtons = $tabList.find('.js-act-as-tab-list-button');

    $tabListButtons.removeClass('is-selected');
  }

  function unselectSiblingTabContentPanels($selectedTabContentPanel) {
    var $tabContent = $selectedTabContentPanel.parents('.js-act-as-tab-content');
    var $tabContentPanels = $tabContent.find('.js-act-as-tab-content-panel');

    $tabContentPanels.removeClass('is-selected');
  }

  function selectTabListButton(tabId) {
    var $selectedTabListButton = $('*[data-selects-tab-content-panel-id="' + tabId + '"]')
    unselectSiblingTabListButtons($selectedTabListButton);
    $selectedTabListButton.addClass('is-selected');
  }

  function selectTabContentPanel(tabId) {
    var $selectedTabContentPanel = $('#' + tabId);
    unselectSiblingTabContentPanels($selectedTabContentPanel);
    $selectedTabContentPanel.addClass('is-selected');
  }

  function selectTabListSelectOption(tabId) {
    var tabListSelect =
    $('.js-act-as-tab-list-select option[value="' + tabId + '"]')
    .parents('.js-act-as-tab-list-select')

    tabListSelect.val(tabId).trigger('change.select2');
  }

  function selectNewTabId(tabId) {
    selectTabListButton(tabId);
    selectTabContentPanel(tabId);
    selectTabListSelectOption(tabId);
  }

  $('.js-act-as-tab-list-button').click(function() {
    selectNewTabId(
      $(this).data('selectsTabContentPanelId')
    );
  });

  $('.js-act-as-tab-list-select').on('change', function() {
    selectNewTabId(
      $(this).val()
    );
  })
}
