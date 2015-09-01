Zack.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'root',
    'projects': 'projectsTab',
    'about': 'aboutTab'
  },

  root: function() {
    var view = new Zack.Views.HomeView()
    this._swapView(view);
  },

  aboutTab: function() {
    var view = new Zack.Views.AboutView()
    this._swapView(view);
  },

  projectsTab: function() {
    var view = new Zack.Views.ProjectsView()
    this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});