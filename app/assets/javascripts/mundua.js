var Mundua = function() {
  var url_api = "/api/v1";

  _searchNomadList = function () {
    var query = url_api + "/nomadlist";
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

      if (method === "POST")
        xhr.setRequestHeader("Content-type", "application/json");

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
