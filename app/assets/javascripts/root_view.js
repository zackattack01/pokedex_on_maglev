Zack.Views.Root = Backbone.View.Extend({
  template: JST['root'],

  initialize: function() {

  },

  render: function() {
    var content = this.template()
    this.$el.html(content);
    return this;
  }
});