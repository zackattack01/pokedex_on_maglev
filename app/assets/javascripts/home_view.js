Zack.Views.HomeView = Backbone.View.extend({
  render: function() {
    var home = new Zack.Collections.Home()
    var that = this;
    home.fetch({
      error: function(obj, resp) {
        that.$el.html(resp['responseText']);
      }
    });
    return this;
  }
});