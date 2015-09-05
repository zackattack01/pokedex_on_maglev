Pokedex.Views.PokeShowView = Backbone.View.extend({
  render: function() {
    var that = this;
    this.model.fetch({
      error: function(obj, resp) {
        that.$el.html(resp['responseText']);
      }
    });
    return this;
  }
});