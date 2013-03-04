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
      attributes: @createAttributes('intro', 0, 1000)
      collection: introList
      })
    
    @experienceList = new BoxList()
    @experienceList.setUrl('http://henriksandstromcv.appspot.com/experience')
    @experienceList.fetch({
      success: => @onExperienceListFetched()
    })

    @educationList = new BoxList()
    @educationList.setUrl('http://henriksandstromcv.appspot.com/education')
    @educationList.fetch({
      success: => @onEducationListFetched()
    })
  
  onEducationListFetched: =>
    console.log 'onEducationListFetched'
    console.log @educationList
    @educationList.add({
      id: 'educationheader'
      className: 'nicetext bluebox well'
      data:{
        '4300' : "opacity:0;transform:translate(" + @width  + "px, 0px);"
        '5300' : "opacity:1;transform:translate(0px, 0px);"
      }
      title: 'Education'
    }, {at: 0})

    @setRandomTranslation(@educationList, 5300, 500, 1000)
    @views.push new BoxListView({
      attributes: @createAttributes('education', 4300, 8000)
      collection: @educationList
    })

    @render()

  onExperienceListFetched: =>
    console.log 'onExperienceListFetched'
    console.log @experienceList
    @experienceList.add({
      id: 'experienceheader'
      className: 'nicetext bluebox well'
      data:{
        '900' : "opacity:0;transform:translate(0px, " + (@height/2- 100) + "px);"
        '1500' : "opacity:1;transform:translate(0px, " + (@height/2- 100) + "px);"
        '2000' : "opacity:1;transform:translate(0px, 0px);"
        '4200' : "opacity:1;transform:translate(0px, 0px);"
        '5200' : "opacity:1;transform:translate(" + -@width + "px, 0px);"
      }
      title: 'Experience'
    }, {at: 0})

    @setRandomTranslation(@experienceList, 2300, 500, 1000)
    @views.push new BoxListView({
      attributes: @createAttributes('experience', 900, 5300)
      collection: @experienceList
    })

    @render()

  rnd: (a,b,x) =>
    return (parseInt(a,10) + parseInt(b*(x + Math.random()), 10))

  createAttributes: (className, entry, exit) =>
    attr = {}
    translateGone = "opacity:0;transform:translate(" + @width  + "px, 0px);"
    translateVisible = "opacity:1;transform:translate(0px, 0px);"
    attr['class'] =  className
    attr['data-' + (entry-1)] = translateGone
    attr['data-' + (entry)] = translateVisible
    attr['data-' + (exit-1)] = translateVisible
    attr['data-' + (exit)] = translateGone
    attr

  setRandomTranslation: (list, start, diffa, diffb) =>  
    dataC = @getDataTranslations(start, diffa, diffb)
  
    end = list.length-1
    for index in [1..end]
      item = list.at(index)
      item.set('data', dataC[index])

  getDataTranslations: (start, diffa, diffb) =>
    translate1 = "opacity:0.2;transform:translate(0px, " + (@height*2) + "px);"
    translate2 = "opacity:1;transform:translate(0px, 0px);"
    translate3 = "opacity:1;transform:translate(0px, 0px);"
    translate4 = "opacity:0;transform:translate(0px, 0px);"

    a = [1..15].map(=> @rnd(start,diffa,0))
    b = a.map((v) => @rnd(v,diffb,0.2))

    dataC = [0..14].map(((i)=>
      coll = {}
      coll[a[i]] = translate1
      coll[b[i]] = translate2
      coll[start+diffa+diffb] = translate3
      coll[start+2*diffa+diffb] = translate4
      coll
    ))

    return dataC

  render: =>
    console.log 'Rendering login view'
    @$el.html('')
    for v in @views
      @$el.append(v.render().el)
    @refresh()
    return @
