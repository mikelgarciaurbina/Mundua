document.addEventListener('DOMContentLoaded', function() {
  if(window.location.pathname == "/"){
    Mundua.searchNomadList().then(handleRecords);
  }
  
  $(".js-typed").typed({
      strings: ["Find the Best Place to Work"],
      loop: false,
      backSpeed: 20,
      typeSpeed: 40
  });

  addEventsToLinks();
});

var url_base_nomadlist = "https://nomadlist.com/";

function handleRecords(cities) {
  var random = Math.floor((Math.random() * 10));
  var resultCities = cities.result.slice(random, random + 12);

  document.getElementsByClassName("js-cities")[0].innerHTML = 
    getCityFromResponse(resultCities);
}

function getCityFromResponse(cities) {
  return cities.reduce(function(result, city) {
    result += cityToHTML(city);
    return result;
  },'');
}

function getStatistics(city){
  var red = "#EA4335";
  var green = "#2AA583";
  var blue = "#15a3ff";
  var obj = {};
  obj.cost = city.cost.beer_in_cafe.USD * 100 / 5;
  if (obj.cost > 95) obj.cost = 95;
  obj.costColor = (obj.cost > 50) ? red : green;
  obj.temperature = city.info.weather.temperature.celsius * 100 / 50;
  if (obj.temperature > 95) obj.temperature = 95;
  obj.temperatureColor = (obj.temperature < 33) ? blue : 
    (obj.temperature < 66) ? green : red;
  obj.humidity = city.info.weather.humidity.value * 100;
  if (obj.humidity > 95) obj.humidity = 95;
  obj.humidityColor = (obj.humidity < 33) ? blue :
    (obj.humidity < 66) ? green : red;
  obj.fun = city.scores.nightlife * 100;
  if (obj.fun > 95) obj.fun = 95;
  obj.funColor = (obj.fun > 50) ? green : red;
  obj.safety = city.scores.safety * 100;
  if (obj.safety > 95) obj.safety = 95;
  obj.safetyColor = (obj.safety > 50) ? green : red;
  return obj;
}

function cityToHTML(city) {
  var statistics = getStatistics(city);
  return '' +
    '<div class="col-4 padding-bottom-20">' +
    '<a href="/search?lat=' + city.info.location.latitude +
             '&lng=' + city.info.location.longitude + '">' + 
      '<div class="bg">' +
        '<img src="' + url_base_nomadlist + city.media.image[500] +
          '" alt="">' +
        '<div class="bg-text">' +
          '<p class="wifi"><i class="fa fa-wifi" aria-hidden="true"></i> ' +
            city.info.internet.speed.download + ' Mbps.</p>' +
          '<h3 class="citi">' + city.info.city.name + '</h3>' +
          '<p>' + city.info.country.name + '</p>' +
          '<p class="weather"><i class="fa fa-cloud" ' +
            'aria-hidden="true"></i> ' +
            city.info.weather.temperature.celsius + 'ºC</p>' +
          '<p class="salary">' + city.cost.longTerm.USD + '$</p>' +
        '</div>' +
        '<div class="overlay">' +
          '<div class="row">' +
            '<div class="col-4">' +
              '<p>Cost</p>' +
              '<p>Weather</p>' +
              '<p>Humidity</p>' +
              '<p>Fun</p>' +
              '<p>Safety</p>' +
            '</div>' +
            '<div class="col-8">' +
              '<p class="progressbar"><span class="real-progressbar"' +
                'style="background: ' + statistics.costColor + ';width: ' +
                  statistics.cost + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + statistics.temperatureColor +
                  ';width: ' + statistics.temperature + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + statistics.humidityColor +
                  ';width: ' + statistics.humidity + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + statistics.funColor + ';width: ' +
                  statistics.fun + '%;"></span></p>' +
              '<p class="progressbar"><span class="real-progressbar"' +
                ' style="background: ' + statistics.safetyColor + ';width: ' +
                  statistics.safety + '%;"></span></p>' +
            '</div>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</a>' +
  '</div>';
}

function addEventsToLinks(){
  var login = document.getElementsByClassName("js-login");
  Array.prototype.forEach.call(login, function(element) {
    element.onclick = function(event){
      loadModal(event, this);
    };
  });
  var joinNow = document.getElementsByClassName("js-join-now");
  Array.prototype.forEach.call(joinNow, function(element) {
    element.onclick = function(event){
      loadModal(event, this);
    };
  });
  var forgotPassword = document.getElementsByClassName("js-forgot-password");
  Array.prototype.forEach.call(forgotPassword, function(element) {
    element.onclick = function(event){
      loadModal(event, this);
    };
  });
}

function loadModal(event, self){
  event.preventDefault();
  Mundua.getDevise(self.pathname).then(function(result){
    var modal = getModal("js-modal-body");
    fillModal(modal, result);
    openModal();
    addEventsToLinks();
  });
}

function getModal(className) {
  return document.getElementsByClassName(className)[0];
}

function fillModal(modal, result){
  modal.innerHTML = getBodyToHtml(result);
}

function openModal() {
  document.location.href = "#modal";
}

function getBodyToHtml(html) {
  return /<aside class="js-content-body">([\s\S]*)<\/aside>/.exec(html)[1];
}