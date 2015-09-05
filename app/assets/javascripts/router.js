Pokedex.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'root',
    'pokemon': 'pokemonIndex',
    'pokemon/:id': 'pokeShow',
    'types/:id': 'typeShow',
    'moves/:id': 'moveShow'
  },

  root: function() {
    var view = new Pokedex.Views.PokeIndexView();
    this._swapView(view);
  },

  pokemonIndex: function() {
    var view = new Pokedex.Views.PokeIndexView();
    this._swapView(view);
  },

  pokeShow: function(id) {
    var pokeModel = new Pokedex.Models.Pokemon({ id: id });
    var view = new Pokedex.Views.PokeShowView({ model: pokeModel });
    this._swapView(view);
  },

  typeShow: function(id) {
    var typeModel = new Pokedex.Models.Type({ id: id });
    var view = new Pokedex.Views.TypeView({ model: typeModel });
    this._swapView(view);
  },

  moveShow: function(id) {
    var moveModel = new Pokedex.Models.Move({ id: id });
    var view = new Pokedex.Views.MoveView({ model: moveModel });
    this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});