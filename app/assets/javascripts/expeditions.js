
window.onload = function () {

  function buildPolylines (coordinates) {
    var segStart = coordinates[0].segment;
    var newPoly = new google.maps.Polyline({
      strokeColor: polyColours[segStart % 8],
      strokeOpacity: 1.0,
      strokeWeight: 4
    });
    newPoly.setMap(map);
    var newPath = newPoly.getPath();
    for (var i = 0; i < coordinates.length; ++i) {
      if (segStart < coordinates[i].segment) {
        segStart += 1;
        var newPoly = new google.maps.Polyline({
          strokeColor: polyColours[coordinates[i].segment % 8],
          strokeOpacity: 1.0,
          strokeWeight: 4
        });
        newPoly.setMap(map);
        var newPath = newPoly.getPath();
      }
      latLng = new google.maps.LatLng(coordinates[i].latitude, coordinates[i].longitude);
      if (coordinates[i].full_path != null) {
        var annotation_id = coordinates[i].annotation_id.toString();
        var contentMarker = new google.maps.Marker({
          map: map,
          draggable: false,
          animation: google.maps.Animation.DROP
        });
        contentMarker.addListener("click", buildAnotationClicker(annotation_id, expeditionId));
        contentMarker.setPosition(latLng);
      }
      map.setCenter(latLng);
      newPath.push(latLng);
    }
  }


  function getAnnotation (annotationId, expeditionId) {
    var csrf = $('meta[name=csrf-token]').attr('content');
    return $.get('/expeditions/'+ expeditionId + '/annotations/grab/', {
      authenticity_token: csrf,
      annotation: {
        id: annotationId
      }
    })
  }

  function buildAnotationClicker (annotation_id, expeditionId) {
    return function () {
      getAnnotation(annotation_id, expeditionId).done(function (response) {
        var annotationDiv = $('.annotationInsert');
        annotationDiv.empty();
        if (response.annotation.full_path.substring(20, 999) == "recording/") {
          annotationDiv.append('<audio controls><source src="' + response.annotation.recording.url +
              '" type="' + response.annotation.content_type + '"><audio>');
        } else if (response.annotation.full_path.substring(20, 999) == "image/") {
          annotationDiv.append('<img src="' + response.annotation.image.medium.url + '">');
        }
        $('.ui.basic.modal')
          .modal('show')
          ;
      }).fail(function (response) {
        console.log("Some ERROR message");
      });
    };
  }

  var timer;
  function locate () {
    var geo = navigator.geolocation;
    if (geo) {
      geo.getCurrentPosition(function (data) {
        latLng = new google.maps.LatLng(data.coords.latitude, data.coords.longitude);
        if (coordinates.length != 0) {
          map.setCenter(latLng);
        }
        if (path.b.length == 0) {
          startMarker.setPosition(latLng);
        }
        marker.setPosition(latLng);
        $('#latitude').html(data.coords.latitude.toString());
        $('#longitude').html(data.coords.longitude.toString());
        $('#accuracy').html(data.coords.accuracy.toString());
        App.coordinates.create({
          coordinate: {
            latitude: data.coords.latitude,
            longitude: data.coords.longitude,
            accuracy: data.coords.accuracy,
            altitude: data.coords.altitude,
            bearing: heading
          },
          expedition: {
            id: expeditionId
          }
        });
      }, function error(msg){
        $("#error").html(msg);
        console.log(msg);
      }, {
        timeout: 10000,
        maximumAge:900,
        enableHighAccuracy: true
      });
    }
    timer = setTimeout(locate, 1000);
  }

  $('#startLocate').on("click", function (e) {
    e.preventDefault();
    locate();
  });

  $('#startLocate').click();

  if (coordinates.length != 0) {
    buildPolylines(coordinates);
  }

  $('#stopLocate').on("click", function (e) {
    e.preventDefault();
    clearTimeout(timer);
  })

  $('#createNote').on("click", function (e) {
    e.preventDefault();
    $('.fullscreen.modal')
      .modal('toggle')
    ;
  })

  $('#submitTitle').on("ajax:success", function (e, data) {
    $('#title').html(data.title);
  });

  $('#submitDescription').on("ajax:success", function (e, data) {
    $('#description').html(data.description);
  });

  $('#submitImage').on("ajax:remotipartComplete", function (e, data) {
    response = JSON.parse(data.responseText);
    latLng = new google.maps.LatLng(response.coordinate.latitude, response.coordinate.longitude);
    var contentMarker = new google.maps.Marker({
      map: map,
      draggable: false,
      animation: google.maps.Animation.DROP
    });
    contentMarker.setPosition(latLng);
    contentMarker.addListener("click", buildAnotationClicker(response.annotation.id, expeditionId));
  });

  $('#submitRecording').on("ajax:remotipartComplete", function (e, data) {
    response = JSON.parse(data.responseText);
    latLng = new google.maps.LatLng(response.coordinate.latitude, response.coordinate.longitude);
    var contentMarker = new google.maps.Marker({
      map: map,
      draggable: false,
      animation: google.maps.Animation.DROP
    });
    contentMarker.setPosition(latLng);
    contentMarker.addListener("click", buildAnotationClicker(response.annotation.id, expeditionId));
  });
}
