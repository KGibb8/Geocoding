App.coordinates = App.cable.subscriptions.create("CoordinatesChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('#distance').html(data.distance_travelled.toString())
    path = poly.getPath();
    coordinate = new google.maps.LatLng(data.coordinate.latitude, data.coordinate.longitude);
    path.push(coordinate);
  },
  create: function(data) {
    return this.perform('create', data);
  }
});
