$( document ).ready(function() {
  var url_base_nomadlist = "https://nomadlist.com/"

  $.ajax({
    url: url_base_nomadlist + "api/v2/list/cities",
    success: handleRecords
  });

  function handleRecords(cities) {
    var random = Math.floor((Math.random() * 10));
    var resultCities = cities.result.slice(random, random + 12);
    $('.js-cities').html(getCityFromResponse(resultCities));
  }

  function getCityFromResponse(cities) {
    return cities.reduce(function(result, city) {
      result += cityToHTML(city);
      return result;
    },'');
  }

  function cityToHTML(city) {
    var red = "#EA4335";
    var green = "#2AA583";
    var blue = "#15a3ff";
    var lat = city.info.location.latitude;
    var long = city.info.location.longitude;
    var cost = city.cost.beer_in_cafe.USD * 100 / 5;
    cost = (cost > 95) ? 95 : cost;
    var costColor = (cost > 50) ? red : green;
    var temperature = city.info.weather.temperature.celsius * 100 / 50;
    temperature = (temperature > 95) ? 95 : temperature;
    var temperatureColor = (temperature < 33) ? blue : (temperature < 66) ? green : red;
    var air = city.info.weather.humidity.value * 100;
    air = (air > 95) ? 95 : air;
    var airColor = (air < 33) ? blue : (air < 66) ? green : red;
    var fun = city.scores.nightlife * 100;
    fun = (fun > 95) ? 95 : fun;
    var funColor = (fun > 50) ? green : red;
    var safety = city.scores.safety * 100;
    safety = (safety > 95) ? 95 : safety;
    var safetyColor = (safety > 50) ? green : red;
    return '' +
      '<div class="col-4">' +
      '<div class="bg">' +
        '<img src="' + url_base_nomadlist + city.media.image[500] + '" alt="">' +
        '<div class="bg-text">' +
          '<p class="wifi"><i class="fa fa-wifi" aria-hidden="true"></i> ' +
            city.info.internet.speed.download + ' Mbps.</p>' +
          '<h3 class="citi">' + city.info.city.name + '</h3>' +
          '<p>' + city.info.country.name + '</p>' +
          '<p class="weather"><i class="fa fa-cloud" aria-hidden="true"></i> ' +
            city.info.weather.temperature.celsius + 'ºC</p>' +
          '<p class="salary">' + city.cost.longTerm.USD + '$</p>' +
        '</div>' +
        '<div class="overlay">' +
          '<div class="row">' +
            '<div class="col-4">' +
              '<p>Cost</p>' +
              '<p>Weather</p>' +
              '<p>Air</p>' +
              '<p>Fun</p>' +
              '<p>Safety</p>' +
            '</div>' +
            '<div class="col-8">' +
              '<p class="progressbar"><span class="real-progressbar"' +
                'style="background: ' + costColor + ';width: ' + cost + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + temperatureColor + ';width: ' + temperature + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + airColor + ';width: ' + air + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + funColor + ';width: ' + fun + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + safetyColor + ';width: ' + safety + '%;"></span></p>' +
            '</div>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</div>';
  }

  $(".js-login").on("click", function(event){
    loadModal(event, $(this));
  });
  $(".js-join-now").on("click", function(event){
    loadModal(event, $(this));
  });
  $(".js-forgot-password").on("click", function(event){
    loadModal(event, $(this));
  });
  function loadModal(event, self){
    event.preventDefault();
    $(".js-modal-body").load(self.attr("href"))
    $(location).attr('href', '#modal-login')
  }
});