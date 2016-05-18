$( document ).ready(function() {
  function setupAutocomplete(){
    var input = $('.js-address-search')[0];
    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.addListener('place_changed', function(){
      var place = autocomplete.getPlace();
      if (place.geometry.location) {
        $(".js-latitude").val(place.geometry.location.lat());
        $(".js-longitude").val(place.geometry.location.lng());
      } else {
        alert("The place has no location...?")
      }
    });
  }
  //if (window.location.pathname == "/houses/new")
    setupAutocomplete();
});
