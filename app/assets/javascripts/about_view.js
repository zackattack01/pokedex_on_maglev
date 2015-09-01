Zack.Views.AboutView = Backbone.View.extend({
  render: function() {
    var about = new Zack.Collections.About();
    var that = this;
    about.fetch({
      error: function(obj, resp) {
        that.$el.html(resp['responseText']);
      }
    });
    return this;
  }
});