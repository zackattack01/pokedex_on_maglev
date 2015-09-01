Zack.Views.ProjectsView = Backbone.View.extend({
  render: function() {
    var projects = new Zack.Collections.Projects()
    var that = this;
    projects.fetch({
      error: function(obj, resp) {
        that.$el.html(resp['responseText']);
      }
    });
    return this;
  }
});