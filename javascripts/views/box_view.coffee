class window.BoxView extends Backbone.View

  initialize: =>
    html = ''
    html += '<p></p><p><span><%= title %></span></p><p></p>' if @model.get('title')
    html += '<p><span class=\"description\"><%= description %></span></p>' if @model.get('description')

    @template = _.template(html)

  
  attributes: =>
    attr = @model.get('attributes')
    attr = {} if not attr
    attr['class'] = @model.get('className')
    _.each(@model.get('data'),( (v,k) =>
      attr['data-' + k] =  v
      ))
    attr['title'] = @model.get('Description')
    attr['data-content'] = @model.get('longdescription') if @model.get('longdescription')

    attr['id'] = @model.get('id')

    return attr
     

  render: =>
    console.log 'Rendering box view'
    @$el.html(@template(@model.toJSON()))
    return @
