var map;
document.addEventListener('DOMContentLoaded', function() {
  if(window.location.pathname == "/search") {
    var container = document.getElementById('popup');
    var content = document.getElementById('popup-content');
    var closer = document.getElementById('popup-closer');

    var overlay = new ol.Overlay({
      element: container,
      autoPan: true,
      autoPanAnimation: {
        duration: 250
      }
    });

    closer.onclick = function() {
      overlay.setPosition(undefined);
      closer.blur();
      return false;
    };

    var longitude = document.getElementsByClassName("js-lng")[0].innerText;
    var latitude = document.getElementsByClassName("js-lat")[0].innerText;

    map = new ol.Map({
      layers: [
        new ol.layer.Tile({ 
          source: new ol.source.XYZ({ 
            url:'http://{1-4}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          })
        })
      ],
      overlays: [overlay],
      target: 'map',
      controls: [],
      view: new ol.View({
        center: ol.proj.transform([eval(longitude),
          eval(latitude)], 'EPSG:4326', 'EPSG:3857'),
        zoom: 12
      })
    });

    map.on('singleclick', function(evt) {
      var coordinate = evt.coordinate;
      var feature = map.forEachFeatureAtPixel(evt.pixel,
          function(feature, layer) {
            return feature;
          });
      if (feature) {
        content.innerHTML = '' +
          '<a href="/houses/' + feature.U.house_id + '" class="black-gray">' +
            '<img class="pull-left width-100 padding-top-5" src="' +
            feature.U.image + '" />' +
          '</a>' +
          '<a href="/houses/' + feature.U.house_id + '" class="black-gray">' +
            '<h5 class="text-15 text700 pull-left padding-top-5">' +
              feature.U.address + 
            '</h5>' +
          '</a>';
        overlay.setPosition(coordinate);
      }
    });
    // change mouse cursor when over marker
    map.on('pointermove', function(evt) {
      var pixel = map.getEventPixel(evt.originalEvent);
      var hit = map.hasFeatureAtPixel(pixel);
      map.getViewport().style.cursor = hit ? 'pointer' : '';
    });

    map.on('moveend', function(evt) {
      getHousesFromApi();
    });

    function getMapExtent() {
      var extent = map.getView().calculateExtent(map.getSize());
      var bottomLeft = ol.proj.transform(ol.extent.getBottomLeft(extent),
          'EPSG:3857', 'EPSG:4326');
      var topRight = ol.proj.transform(ol.extent.getTopRight(extent),
          'EPSG:3857', 'EPSG:4326');
      return [bottomLeft[0], bottomLeft[1], topRight[0], topRight[1]];
    }

    function getHousesFromApi() {
      Mundua.getHousesInApi(getMapExtent()).then(handleHouses);
    }

    function handleHouses(houses) {
      var markers = [];
      houses.forEach(function (house, index, array) {
         markers.push(createMarker(house));
      });

      var vectorSource = new ol.source.Vector({
        features: markers
      });

      var vectorLayer = new ol.layer.Vector({
        source: vectorSource
      });
      var layers = map.getLayers();
      if(layers.a[1])
        map.removeLayer(layers.a[1]);
      map.addLayer(vectorLayer);

      if (houses.length > 0)
        document.getElementsByClassName("js-houses-list-search")[0].innerHTML =
          getHousesFromResponse(houses);
      else
        document.getElementsByClassName("js-houses-list-search")[0].innerHTML =
          housesNotFoundHTml();
    }

    var iconStyle = new ol.style.Style({
      image: new ol.style.Icon({
        anchor: [0.5, 40],
        anchorXUnits: 'fraction',
        anchorYUnits: 'pixels',
        opacity: 0.9,
        src: '/images/marker.svg'
      })
    });

    function createMarker(house) {
      var iconFeature = new ol.Feature({
        geometry: new ol.geom.Point(ol.proj.transform([eval(house.longitude),
          eval(house.latitude)], 'EPSG:4326', 'EPSG:3857')),
        house_id: house.id,
        image: house.image_url,
        rooms: house.rooms,
        address: house.address
      });
      
      iconFeature.setStyle(iconStyle);

      return iconFeature;
    }
  }
});

function getHousesFromResponse(houses) {
  return houses.reduce(function(result, house) {
    result += houseToHTML(house);
    return result;
  },'');
}

function houseToHTML(house) {
  var color = "";
  if(house.how_many_users_in_house == 0) {
    color = "light-green";
  } else if(house.how_many_users_in_house >= house.rooms) {
    color = "red";
  } else {
    color = "orange";
  }
  return '' +
    '<div class="col-6">' +
    '<div class="item white shadow cf">' +
        '<div class="row padding">' +
          '<div class="col-11 col-persist gutter-h-10 padding-top-5' +
            ' title-height">' +
            '<h5 class="text-15 text700 pull-left">' +
              '<a href="/houses/' + house.id + '" class="black-gray">' +
                house.address + 
              '</a>' +
            '</h5>' +
          '</div>' +
        '</div>' +
        '<div class="row img-height">' +
          '<a href="/houses/' + house.id + '" class="black-gray">' +
            '<img class="pull-left width-100" src="' + house.image_url +
              '" />' +
          '</a>' +
        '</div>' +
        '<div class="row padding">' +
          '<div class="pull-left">' +
            '<a href="/houses/' + house.id + '" class="btn icon round hover-tooltip' +
              ' text-' + color + ' fill-silver">' +
              '<span class="tooltip top">Rooms in this house</span>' +
              '<i class="fa fa-bed"></i>' +
            '</a>' +
            '<a class="btn white hover-disable text-' +
              color + ' text600">' +
              house.rooms +
            '</a>' +
          '</div>' +
          '<div class="pull-right">' +
            '<a href="/houses/' + house.id + '" class="btn icon round' +
              ' text-gray hover-text-red">' +
              '<i class="fa fa-users"></i>' +
            '</a>' +
            '<a class="btn white hover-disable text-gray text600">' +
              house.groups_count +
            '</a>' +
          '</div>' +
        '</div>' +
    '</div>' +
  '</div>';
}

function housesNotFoundHTml() {
  return '' +
    '<div class="col-12 padding-top">' +
      '<center>' + 
      '<h4>Houses not found in this place</h4>' +
      '</center>' +
    '</div>';
}