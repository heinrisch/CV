Router = Backbone.Router.extend({
  routes: {
    '' : 'cv'
  }

  cv: =>
    console.log 'Loading Main view'
    view = new MainView()
    console.log view.render().el
    $('#skrollr-body').html(view.render().el)
  
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

for i in @includes
  console.log 'including: ' + i
  loadScript('javascripts/' + i, =>
    console.log 'Checking if ready: ' + @includesCounter
    @includesCounter--
    startIfReady()
  )



startApp = =>
  new Router()
  Backbone.history.start()
  skrollr.init({forceHeight: false})
  $('.workbox').popover({
    trigger: 'hover'
    animation: true
    placement: 'bottom'
    })

$ =>
  @documentDone = true
  startIfReady()

startIfReady = =>
  if @documentDone and @includesCounter == 0
    startApp()
