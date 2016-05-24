// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require ol.js
//= require jquery
//= require jquery_ujs
//= require typed.js.js
//= require typeahead.bundle.min.js
//= require_tree .

function setNavigation(){
  var nav = document.getElementsByClassName("js-profile-nav")[0];
  nav = (nav) ? nav.getElementsByTagName("a") : [];
  Array.prototype.forEach.call(nav, function(element) {
    if(element.pathname === window.location.pathname){
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

var Mundua = function() {
    var url_base_nomadlist = "https://nomadlist.com/";
    var url_api = "/api/v1";

    _searchNomadList = function () {
        var query = url_base_nomadlist + "api/v2/list/cities";
        return _proxy('GET', query, 'json' );
    };

    _getDevise = function (query) {
        return _proxy('GET', query, 'text' );
    };

    _getUserData = function (query) {
        return _proxy('GET', query, 'text' );
    };

    _getHousesInApi = function (coordinates) {
        var query = url_api + "/houses";
        query += "?coordinates=" + coordinates.join(", ");
        return _proxy('GET', query, 'json', coordinates );
    };

    _proxy = function(method, url, responseType, params) {
        return new Promise(function(resolve, reject) {
            var xhr = new XMLHttpRequest();

            xhr.open(method, url);
            xhr.withCredentials = false;
            xhr.responseType = responseType;

            xhr.onload = function() {
                if (xhr.status === 200){
                    resolve(xhr.response);
                } else {
                    reject(console.log(xhr.statusText));
                }
            };

            xhr.onerror = function() {
                reject(console.log('Error'));
            }

            xhr.send(params);
        });
    };

    return {
        searchNomadList : _searchNomadList,
        getDevise       : _getDevise,
        getHousesInApi  : _getHousesInApi,
        getUserData     : _getUserData
    }
}();