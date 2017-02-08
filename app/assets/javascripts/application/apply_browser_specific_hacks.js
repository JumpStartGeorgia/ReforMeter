// When the browser is safari, this function adds the class safari-only to any
// elements that need it.

function applyBrowserSpecificHacks() {
  function browserIsSafari() {
    return ((navigator.userAgent.indexOf('Safari') != -1) &&
           (navigator.userAgent.indexOf('Chrome') == -1))
  }

  function addSafariOnlyClass() {
    if (browserIsSafari()) {
      $('.js-add-class_safari-only').addClass('safari-only')
    }
  }

  addSafariOnlyClass();
}
