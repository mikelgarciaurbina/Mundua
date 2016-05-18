$( document ).ready(function() {
  //TODO refactor
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
    if($('.js-address-search')[1]){
      var input2 = $('.js-address-search')[1];
      var autocomplete2 = new google.maps.places.Autocomplete(input2);
      autocomplete2.addListener('place_changed', function(){
        var place = autocomplete2.getPlace();
        if (place.geometry.location) {
          $(".js-latitude").val(place.geometry.location.lat());
          $(".js-longitude").val(place.geometry.location.lng());
        } else {
          alert("The place has no location...?")
        }
      });
    }
  }
  //if (window.location.pathname == "/houses/new")
    setupAutocomplete();
});
