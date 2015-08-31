window.Zack = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $el = $('#dynamic-content');
    alert("yayabackbone")
    // new Zack.Routers.Router({ $rootEl: $el });
    Backbone.history.start();
  }
};