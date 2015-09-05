window.Pokedex = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $el = $('#dynamic-content');
    new Pokedex.Routers.Router({ $rootEl: $el });
    Backbone.history.start();
  }
};