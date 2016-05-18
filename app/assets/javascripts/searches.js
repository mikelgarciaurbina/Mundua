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

    addMarkerToMap();

    map.on('singleclick', function(evt) {
      var coordinate = evt.coordinate;
      var feature = map.forEachFeatureAtPixel(evt.pixel,
          function(feature, layer) {
            return feature;
          });
      if (feature) {
        content.innerHTML = feature.U.name;
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
      console.log(houses);
    }
    function addMarkerToMap(){
      var iconFeature = new ol.Feature({
        geometry: new ol.geom.Point(ol.proj.transform([eval($(".js-lng").text()), eval($(".js-lat").text())], 'EPSG:4326', 'EPSG:3857')),
        name: 'Null Island',
        population: 4000,
        rainfall: 500
      });
      var iconStyle = new ol.style.Style({
        image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
          anchor: [0.5, 40],
          anchorXUnits: 'fraction',
          anchorYUnits: 'pixels',
          opacity: 0.9,
          src: '/images/marker.svg'
        }))
      });
      iconFeature.setStyle(iconStyle);

      var vectorSource = new ol.source.Vector({
        features: [iconFeature]
      });

      var vectorLayer = new ol.layer.Vector({
        source: vectorSource
      });
      map.addLayer(vectorLayer);
    }
  }
});