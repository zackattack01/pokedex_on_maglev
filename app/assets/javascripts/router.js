Zack.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'root',
    'projects': 'projectsTab',
    'about': 'aboutTab',
    'pokemon': 'pokemonIndex',
    'pokemon/:id': 'pokeShow'
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
    var view = new Zack.Views.PokeIndexView();
    this.$rootEl.css('opacity', '1');
    this._swapView(view);
  },

  pokeShow: function(id) {
    var pokeModel = new Zack.Models.Pokemon({ id: id });
    var view = new Zack.Views.PokeShowView({ model: pokeModel });
    this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});