$( document ).ready(function() {
  //TODO refactor
  function setupAutocomplete(){
    var autocomplete = new google.maps.places.Autocomplete($('.js-address-search')[0]);
    autocomplete.addListener('place_changed', onPlaceChanged);
    if($('.js-address-search')[1]){
      var autocomplete2 = new google.maps.places.Autocomplete($('.js-address-search')[1]);
      autocomplete2.addListener('place_changed', onPlaceChanged);
    }
  }
  
  function onPlaceChanged(){
    var place = this.getPlace();
    if (place.geometry.location) {
      $(".js-latitude").val(place.geometry.location.lat());
      $(".js-longitude").val(place.geometry.location.lng());
    } else {
      alert("The place has no location...?")
    }
  }

  setupAutocomplete();
});
