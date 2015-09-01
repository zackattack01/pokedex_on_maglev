Zack.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'root'
  },

  root: function() {
    var rootView = new Zack.Views.RootView()
    this.$rootEl.html(this.rootView.render().$el);
  }
});