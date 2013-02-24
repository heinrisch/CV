class window.MainView extends Backbone.View

  initialize: =>
    @views = []

    width = $(window).width()
    height = $(window).height()

    console.log width + 'x' + height

    introList = new BoxList()
    introList.reset([{
      id: 'introtext'
      className : 'nicetext bluebox introtext centered well'
      data: {
        "0" : "opacity:1;transform:translate(0px, " + (height/2- 100) + "px);"
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

    translate1 = "opacity:0.2;transform:translate(0px, " + (height*2) + "px);"
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

    experienceList = new BoxList()
    experienceList.reset([{
      id: 'experienceheader'
      className: 'nicetext bluebox well'
      data:{
        '900' : "opacity:0;transform:translate(0px, " + (height/2- 100) + "px);"
        '1500' : "opacity:1;transform:translate(0px, " + (height/2- 100) + "px);"
        '2000' : "opacity:1;transform:translate(0px, 0px);"

      }
      title: 'Experience'
    },
    {
      id: 'wrapp'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Wrapp'
      description: 'Android Developer'
      longdescription: 'Working in the user facing team with responsibility for the Android client.'
    },
    {
      id: 'sbla'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Sbla'
      description: "Founder/Consultant"
      longdescription: 'Android development company founded in late 2010 after about a year of hobby development. Sbla works on both in-house app and game development as well as projects for external customers.'
    },
    {
      id: 'orc'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'ORC'
      description: "Team Lead/Client Developer"
      longdescription: 'Was team lead for the main team working with the Orc Trader. Team consisted of 5 developers of 3 testers doing agile/lean development in Kanban style.'
    },
    {
      id: 'google'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Google'
      description: "Speech Data Specialist"
      longdescription: 'Helping out with one of their projects over the summer'
    },
    {
      id: 'ericsson'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Ericsson'
      description: 'Thesis Work'
      longdescription: 'Developing a format for storing and handling indoor-maps.'
    },
    {
      id: 'kth'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Royal Institue of Technology'
      description: 'Lab Assistant'
      longdescription: 'Many different courses helping students with
      programming and problem solving in: Python, Java, Haskell, Prolog, OpenGL,
      C/C++, and Syntax Analysis.'
    },
    {
      id: 'pwc'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'PriceWaterHouseCoopers'
      description: 'IT-Administrator'
      longdescription: 'Worked as the leader of a group of 7 people. The main task was to upgrade computers and servers in many different locations in Sweden. I was also responsible for updating the company\'s database with the relevant information.'
    },
    {
      id: 'onealyze'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Onealyze'
      description: 'Software Developer'
      longdescription: 'Worked with various programming assignments involving mainly PHP, SQL, and Javascript for companies such as TV4 (Swedish TV channel) and Husqvarna.'
    },
    {
      id: 'nordvaxt'
      className: 'nicetext wrapp floatleft workbox img-rounded'
      title: 'Nordv&auml;xt Intressenter'
      description: 'Mentor'
      longdescription: 'Worked as a mentor with First Lego League. Helped children in grade 7 through 9 to build and program Lego robots. I was also a referee at the local First Lego League competition in Stockholm.'
    }
    ])

    end = experienceList.length-1
    for index in [1..end]
      item = experienceList.at(index)
      item.set('data', dataC[index])
    
    @views.push new BoxListView({
      attributes:{
        class: 'experience'
      }
      collection: experienceList
    })

  rnd: (a,b,x) =>
    return (parseInt(a,10) + parseInt(b*(x + Math.random()), 10))

  render: =>
    console.log 'Rendering login view'
    @$el.html('')
    for v in @views
      @$el.append(v.render().el)
    return @
