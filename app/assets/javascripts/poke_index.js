Pokedex.Views.PokeIndexView = Backbone.View.extend({
  render: function() {
    var pokes = new Pokedex.Collections.Pokemons();
    var that = this;
    pokes.fetch({
      error: function(obj, resp) {
        that.$el.html(resp['responseText']);
      }
    });
    return this;
  }
});