var polyColours = ["#003366", "#009933", "#99cc00", "#ffcc00", "#cc6699", "#9966ff", "#996600", "#cc99ff"]
var map;
var poly;
var path;
var heading;
var startMarker;
var marker;
var contentMarker;
var infoWindow;
var lastInfoWindow;
var infoWindowClosed;
var infoWindowClosed = true;

function initMap() {
  var compassSpan = document.getElementById("compass");
  heading = 0.0;
  // Obtain a new *world-oriented* Full Tilt JS DeviceOrientation Promise
  var promise = FULLTILT.getDeviceOrientation({ type: 'world'  });

  // Wait for Promise result
  promise.then(function(deviceOrientation) {
    // Apparently device orientation events are supported, so register a callback
    deviceOrientation.listen(function() {
      // Get the current *screen-adjusted* device orientation angles
      var currentOrientation = deviceOrientation.getScreenAdjustedEuler();
      console.log(currentOrientation);
      // Calculate the current compass heading that the user is facing (in degrees)
      heading = 360 - currentOrientation.alpha;
      compassSpan.innerHTML = heading.toString();
    });
  }).catch(function(errorMessage) {
    // Device Orientation Events are not supported
    console.log(errorMessage);
  });
  map = new google.maps.Map(document.getElementById('map'), {
    minZoom: 3,
    zoom: 16,
    mapTypeId: 'satellite'
  });
  startMarker = new google.maps.Marker({
    map: map,
    draggable: false
  });
  marker = new google.maps.Marker({
    map: map,
    draggable: false
  });
  dropMarker = new google.maps.Marker({
    map: map,
    draggable: false,
    animation: google.maps.Animation.DROP
  });
  map.addListener('click', function (e) {
    dropMarker.setVisible(true);
    dropMarker.setPosition(e.latLng);
  });
  poly = new google.maps.Polyline({
    strokeColor: polyColour,
    strokeOpacity: 1.0,
    strokeWeight: 4
  });
  poly.setMap(map);
  path = poly.getPath();
}
