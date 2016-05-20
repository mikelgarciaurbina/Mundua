document.addEventListener('DOMContentLoaded', function() {
  function setupAutocomplete(){
    var searchAddress = document.getElementsByClassName("js-address-search")
    var autocomplete = new google.maps.places.Autocomplete(searchAddress[0]);
    autocomplete.addListener('place_changed', onPlaceChanged);
    if(searchAddress[1]){
      var autocomplete2 = new google.maps.places.Autocomplete(searchAddress[1]);
      autocomplete2.addListener('place_changed', onPlaceChanged);
    }
  }
  
  function onPlaceChanged(){
    var place = this.getPlace();
    if (place.geometry.location) {
      var latitude = document.getElementsByClassName("js-latitude");
      Array.prototype.forEach.call(latitude, function(element) {
        element.value = place.geometry.location.lat();
      });
      var longitude = document.getElementsByClassName("js-longitude");
      Array.prototype.forEach.call(longitude, function(element) {
        element.value = place.geometry.location.lng();
      });
    } else {
      alert("The place has no location...?")
    }
  }

  setupAutocomplete();
});
