class window.MainView extends Backbone.View

  initialize: (refresh) =>
    @refresh = refresh
    @views = []

    @width = $(window).width()
    @height = $(window).height()

    console.log @width + 'x' + @height

    introList = new BoxList()
    introList.reset([{
      id: 'introtext'
      className : 'nicetext bluebox introtext centered well'
      data: {
        "0" : "opacity:1;transform:translate(0px, " + (@height/2- 100) + "px);"
        "1000" : "opacity:0;transform:translate(0px, -200px);"
      }
      title: "Henrik Sandström"
      description: "CV 2013"
      longdescription: 'Scroll down!'
    }])
    @views.push new BoxListView({
      attributes:{
         'class': 'intro'
         }
      collection: introList
      })
    
    @experienceList = new BoxList()
    @experienceList.setUrl('http://henriksandstromcv.appspot.com/experience')
    @experienceList.fetch({
      success: => @onExperienceListFetched()
      remove: false
    })

  onExperienceListFetched: =>
    console.log 'onExperienceListFetched'
    
    @experienceList.add({
      id: 'experienceheader'
      className: 'nicetext bluebox well'
      data:{
        '900' : "opacity:0;transform:translate(0px, " + (@height/2- 100) + "px);"
        '1500' : "opacity:1;transform:translate(0px, " + (@height/2- 100) + "px);"
        '2000' : "opacity:1;transform:translate(0px, 0px);"
      }
      title: 'Experience'
    }, {at: 0})

    
    
    
    translate1 = "opacity:0.2;transform:translate(0px, " + (@height*2) + "px);"
    translate2 = "opacity:1;transform:translate(0px, 0px);"

    start = 2300
    diffa = 500
    diffb = 1000

    a = [1..15].map(=> @rnd(start,diffa,0))
    b = a.map((v) => @rnd(v,diffb,0.2))

    dataC = [0..14].map(((i)=>
      coll = {}
      coll[a[i]] = translate1
      coll[b[i]] = translate2

      coll
    ))
  
    end = @experienceList.length-1
    for index in [1..end]
      item = @experienceList.at(index)
      item.set('data', dataC[index])
    
    @views.push new BoxListView({
      attributes:{
        class: 'experience'
      }
      collection: @experienceList
    })

    @render()

  rnd: (a,b,x) =>
    return (parseInt(a,10) + parseInt(b*(x + Math.random()), 10))

  render: =>
    console.log 'Rendering login view'
    @$el.html('')
    for v in @views
      @$el.append(v.render().el)
    @refresh()
    return @
