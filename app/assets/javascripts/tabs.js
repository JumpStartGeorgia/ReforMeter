function setupTabs() {
  $('.js-act-as-tab-list-button').click(function() {
    var $selectedTabListButton = $(this);
    var $tabList = $selectedTabListButton.parents('.js-act-as-tab-list');
    var $tabListButtons = $tabList.find('.js-act-as-tab-list-button');

    $tabListButtons.removeClass('is-selected');
    $selectedTabListButton.addClass('is-selected');

    var $selectedTabContentPanel = $('#' + $selectedTabListButton.data('selectsTabContentPanelId'));
    var $tabContent = $selectedTabContentPanel.parents('.js-act-as-tab-content');
    var $tabContentPanels = $tabContent.find('.js-act-as-tab-content-panel');

    $tabContentPanels.removeClass('is-selected');
    $selectedTabContentPanel.addClass('is-selected');
  });
}
