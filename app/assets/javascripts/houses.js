document.addEventListener('DOMContentLoaded', function() {
  setupAutocomplete();
});

function setupAutocomplete() {
  var searchAddress = document.getElementsByClassName("js-address-search");
  var autocomplete = new google.maps.places.Autocomplete(searchAddress[0]);
  autocomplete.addListener('place_changed', onPlaceChanged);

  if(searchAddress[1]) {
    var autocomplete2 = new google.maps.places.Autocomplete(searchAddress[1]);
    autocomplete2.addListener('place_changed', onPlaceChanged);
  }
}

function onPlaceChanged() {
  var place = this.getPlace();
  if (place.geometry.location) {
    setLatToAllDivs("js-latitude", place);
    setLngToAllDivs("js-longitude", place);
  } else {
    alert("The place has no location...?");
  }
}

function setLatToAllDivs(className, place) {
  var container = document.getElementsByClassName(className);
  Array.from(container).forEach(function(element) {
    element.value = place.geometry.location.lat();
  });
}

function setLngToAllDivs(className, place) {
  var container = document.getElementsByClassName(className);
  Array.from(container).forEach(function(element) {
    element.value = place.geometry.location.lng();
  });
}