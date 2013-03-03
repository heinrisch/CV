Router = Backbone.Router.extend({
  routes: {
    '' : 'cv'
  }

  cv: =>
    console.log 'Loading Main view'
    view = new MainView(@refresh)
    $('#skrollr-body').html(view.render().el)
    @refresh()
  
})

loadScript = (url, callback) =>
   head = document.getElementsByTagName('head')[0]
   script = document.createElement('script')
   script.type = 'text/javascript'
   script.src = url

   script.onreadystatechange = callback
   script.onload = callback

   head.appendChild(script)

@includes = ['views/box_view.js', 'views/box_list_view.js', 'views/main_view.js', 'models/box.js', 'models/box_list.js']
@includesCounter = @includes.length
@documentDone = false

i = 0
recInclude = =>
  if i < @includes.length
    item = @includes[i++]
    console.log 'including: ' + item
    loadScript('javascripts/' + item, =>
      @includesCounter--
      console.log 'Checking if ready: ' + @includesCounter
      startIfReady() if @includesCounter == 0
      recInclude()
    )
recInclude()

@refresh = =>
  @skrollrObject.refresh()
  $('div').popover({
    trigger: 'hover'
    animation: true
    placement: 'bottom'
    container: 'body'
    })

startApp = => 
  @skrollrObject = skrollr.init({forceHeight: false})
  new Router()
  Backbone.history.start()

$ =>
  @documentDone = true
  startIfReady()

startIfReady = =>
  console.log "start if ready: " + @documentDone + ", " + @includeCounter
  if @documentDone and @includesCounter == 0
    startApp()
