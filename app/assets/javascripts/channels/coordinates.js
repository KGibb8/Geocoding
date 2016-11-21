App.coordinates = App.cable.subscriptions.create("CoordinatesChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    debugger
  },
  create: function() {
    return this.perform('create');
  }
});
