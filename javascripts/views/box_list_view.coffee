class window.BoxListView extends Backbone.View

  render: =>
    console.log 'Rendering list box view'
    @$el.html('')
    for box in @collection.models
      boxView = new BoxView({model: box})
      @$el.append(boxView.render().el)
    return @

