Zack.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'root',
    'projects': 'projectsTab',
    'about': 'aboutTab',
    'pokemon': 'pokemonIndex'
  },

  root: function() {
    var view = new Zack.Views.HomeView();
    $('#nav-tabs li').removeClass('active');
    $('#nav-tabs li#home').addClass('active');
    this._swapView(view);
  },

  aboutTab: function() {
    var view = new Zack.Views.AboutView();
    $('#nav-tabs li').removeClass('active');
    $('#nav-tabs li#about').addClass('active');
    this._swapView(view);
  },

  projectsTab: function() {
    var view = new Zack.Views.ProjectsView()
    $('#nav-tabs li').removeClass('active');
    $('#nav-tabs li#projects').addClass('active');
    this._swapView(view);
  },

  pokemonIndex: function() {
    
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});