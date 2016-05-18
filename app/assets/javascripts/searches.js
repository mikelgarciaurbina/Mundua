var map;
$( document ).ready(function() {
  if(window.location.pathname == "/search"){
    var container = document.getElementById('popup');
    var content = document.getElementById('popup-content');
    var closer = document.getElementById('popup-closer');

    var overlay = new ol.Overlay(/** @type {olx.OverlayOptions} */ ({
      element: container,
      autoPan: true,
      autoPanAnimation: {
        duration: 250
      }
    }));

    closer.onclick = function() {
      overlay.setPosition(undefined);
      closer.blur();
      return false;
    };

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
        center: ol.proj.transform([eval($(".js-lng").text()), eval($(".js-lat").text())], 'EPSG:4326', 'EPSG:3857'),
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
          '<img class="pull-left width-100 padding-top-5" src="' +
            feature.U.image + '" />' +
          '<h5 class="text-15 text700 pull-left padding-top-5">' + 
            feature.U.address + 
          '</h5>';
        overlay.setPosition(coordinate);
      }
    });
    // change mouse cursor when over marker
    map.on('pointermove', function(e) {
      var pixel = map.getEventPixel(e.originalEvent);
      var hit = map.hasFeatureAtPixel(pixel);
      map.getViewport().style.cursor = hit ? 'pointer' : '';
    });

    var extent = map.getView().calculateExtent(map.getSize());
    var point1 = ol.proj.transform([extent[0], extent[1]], 'EPSG:3857', 'EPSG:4326');
    var point2 = ol.proj.transform([extent[2], extent[3]], 'EPSG:3857', 'EPSG:4326');
    var data = [point1[0], point1[1], point2[0], point2[1]];
    $.ajax({
      url: '/api/v1/houses',
      dataType: 'json',
      type: 'GET',
      data: {
        coordinates: data
      },
      success: handleRecords,
      error: function() {
        console.log("Error");
      }
    });

    function handleRecords(houses) {
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
      map.addLayer(vectorLayer);

      $('.js-houses-list-search').html(getHousesFromResponse(houses));
    }

    var iconStyle = new ol.style.Style({
      image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
        anchor: [0.5, 40],
        anchorXUnits: 'fraction',
        anchorYUnits: 'pixels',
        opacity: 0.9,
        src: '/images/marker.svg'
      }))
    });

    function createMarker(house){
      var iconFeature = new ol.Feature({
        geometry: new ol.geom.Point(ol.proj.transform([eval(house.longitude), eval(house.latitude)], 'EPSG:4326', 'EPSG:3857')),
        house_id: house.id,
        image: house.image_url,
        rooms: house.rooms,
        address: house.address
      });
      
      iconFeature.setStyle(iconStyle);

      return iconFeature;
    }

    function getHousesFromResponse(houses) {
      return houses.reduce(function(result, house) {
        result += houseToHTML(house);
        return result;
      },'');
    }

    function houseToHTML(house) {
      var color = "";
      if(house.users_count == 0) {
        color = "light-green";
      } else if(house.users_count >= house.rooms){
        color = "red";
      } else {
        color = "orange";
      }
      return '' +
        '<div class="col-6">' +
        '<div class="item white shadow cf">' +
            '<div class="row padding">' +
              '<div class="col-11 col-persist gutter-h-10 padding-top-5">' +
                '<h5 class="text-15 text700 pull-left">' + 
                  house.address + 
                '</h5>' +
              '</div>' +
            '</div>' +
            '<div class="row">' +
             '<img class="pull-left width-100" src="' + house.image_url + '" />' +
            '</div>' +
            '<div class="row padding">' +
              '<div class="pull-left">' +
                '<a class="btn icon round text-' + color + ' fill-silver">' +
                  '<i class="fa fa-bed"></i>' +
                '</a>' +
                '<a class="btn white hover-disable text-' + color + ' text600">' +
                  house.rooms +
                '</a>' +
              '</div>' +
              '<div class="pull-right">' +
                '<a class="btn icon round text-gray hover-text-red">' +
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
  }
});