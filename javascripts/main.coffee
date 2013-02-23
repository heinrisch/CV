@items = [$('#introtext'), $('#part1text')]

window.onload = =>
  @setSizeVariables()
  @centerItems()
  @addBubbles()
  skrollr.init({
    forceHeight: false
  })


window.onresize = =>
  @setSizeVariables()
  @centerItems()

@setSizeVariables = =>
  @height = $(window).height()
  @width = $(window).width()

@centerItems = =>
  for item in @items
     item.css({'margin-top':(@height/2-item.height()/2)})

@addBubbles = =>
  @z = d3.scale.category20c()
  @i = 0

  @svg = d3.select("#intro").append("svg:svg").attr("width", "100%").attr("height", "100%").attr("position","absolute")

  setInterval((=> @addBubble()), 300)

@addBubble = =>
  x = Math.random()*@width
  y = Math.random()*@height

  @svg.append("svg:circle")
      .attr("cx", x)
      .attr("cy", y + 100)
      .attr("r", 1e-6)
      .style("stroke", "lightblue")
      .style("stroke-opacity", 1)
      .style("fill", "lightblue")
      .style("stroke-width", "2px")
     .transition()
      .duration(5000)
      .ease('linear')
      .attr("r", 50)
      .style("stroke-opacity", 1e-6)
      .attr("cy", (y - 200))
      .remove();
