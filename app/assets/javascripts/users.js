function setNavigation() {
  var nav = document.getElementsByClassName("js-profile-nav")[0];
  nav = (nav) ? nav.getElementsByTagName("a") : [];
  Array.from(nav).forEach(function(element) {
    if(element.pathname === window.location.pathname) {
      element.classList.add("active");
    }
  });
}

document.addEventListener('DOMContentLoaded', function() {
  setNavigation();
  setTimeout(function() {
    document.getElementsByClassName("js-flash")[0].classList.add("fade-out-up");
  }, 3500);
});