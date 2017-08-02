// d3

var svg = d3.select("svg")

var color = d3.scaleOrdinal(d3.schemeCategory20);

var simulation = d3.forceSimulation()
    .force("link", d3.forceLink().distance(100).id(function(d) { return d.id; }))
    .force("charge", d3.forceManyBody().strength(-200))



resize();
d3.select(window).on("resize", resize);

function resize() {
  var width = window.innerWidth,
      height = window.innerHeight /3;
  svg.attr("width", width).attr("height", height);
  simulation.force("center", d3.forceCenter(width/2, height/2)).restart();
};


var urbToGraph = function(data){
  var nodeColors = {}
  var links = []
  var OUR = "~"+window.urb.ship;
  for (var source in data.net) {
    nodeColors[source] = nodeColors[source] || ""
    for (var target in data.net[source]){
      nodeColors[target] = data.net[source][target] || ""
      if(target == OUR &&
         data.net[target] &&
         data.net[target].includes(source))
           continue
      links.push({
        source:source,
        target:target,
        value: source == OUR ? 3 : 3,
        distance: source == OUR ? 0 : 1
      })
    }
  }
  if(nodeColors[OUR] != null) nodeColors[OUR] = data.col

  var nodes = []
  for (var node in nodeColors) {
    var _node = {id:node, size: node == OUR ? 4 : 3, color: nodeColors[node]}
    // if(node == OUR){
    //   _node.x = svg.attr("width") / 2
    //   _node.y = svg.attr("height") / 2
    // }
    nodes.push(_node)
  }
  return {nodes:nodes, links:links}
}

var link = svg.append("g")
              .attr("class", "links").selectAll("line")
var node = svg.append("g")
              .attr("class", "nodes").selectAll(".node")

var drawGraph = function(error, urbData) {
  var graph = urbToGraph(urbData)
  console.log(graph)
  if (error) throw error;

  link = link.data(graph.links, function(d) { return d.source.id + "-" + d.target.id; })
  link.exit().remove();
  link = link.enter().append("line")
    .attr("class", "link")
    .attr("stroke-width", function(d) { return d.value; })
    .attr("stroke", function(d){return ["#9ee574","#11d"][d.distance]})
    .merge(link)

  node = node.data(graph.nodes, function(d) { return d.id })
  node.exit().remove()

  var new_node = node.enter().append("g")
                   .attr("class","node")
                   .call(d3.drag()
                       .on("start", dragstarted)
                       .on("drag", dragged)
                       .on("end", dragended))

  new_node.append("circle")
      // .attr("stroke", "#000")
      .attr("r", 6)

  new_node.append("text")
      .attr("x", 12)
      .attr("dy", ".45em")
      .text(function(d){ return d.id})
      .attr("font-size", function(d){ return 5*d.size + "px"})


  // node.append("title")
  //     .text(function(d) { return d.id; });
  node= new_node.merge(node)
  node.select("circle")
      .attr("fill", function(d) { console.log(this,d); return d.color || "#ccc"; })
      .attr("stroke", function(d) { return d.color || "#ccc"; })


  simulation
      .nodes(graph.nodes)
      .on("tick", ticked);

  simulation.force("link")
      .links(graph.links);

  simulation.alpha(1).restart()

  function ticked() {
    link
        .attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node
        .attr("transform", function(d) {
    	    return "translate(" + d.x + "," + d.y + ")"; });
        // .attr("x", function(d) { return d.x; })
        // .attr("y", function(d) { return d.y; });
  }
}

function dragstarted(d) {
  if (!d3.event.active) simulation.alphaTarget(0.3).restart();
  d.fx = d.x;
  d.fy = d.y;
}

function dragged(d) {
  d.fx = d3.event.x;
  d.fy = d3.event.y;
}

function dragended(d) {
  if (!d3.event.active) simulation.alphaTarget(0);
  d.fx = null;
  d.fy = null;
}

// urb

function subscribe() {
  var ship = document.getElementById('subscribeBox').value;

  window.urb.send(
    ship,                                               // data
    {                                                   // params
      appl: 'mesh',
      mark: 'mesh-friend',
      ship: window.urb.user
    },
    function subscribed(error, response) {              // callback
      if (error || !response.data || response.fail) {
        console.warn('`urb.send` to ~' + window.urb.user + ' the data payload:');
        console.warn(ship);
        console.warn('failed. Error:');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('`urb.send` to ~' + window.urb.user + ' the data payload:');
      console.log(ship);
      console.log('succeeded! Response:');
      console.log(response.data);
    });
}

function selectColor(color) {
  window.urb.send(
    color,                                               // data
    {                                                   // params
      appl: 'mesh',
      mark: 'mesh-color',
      ship: window.urb.user
    })
}

// onLoad

(function bindNetwork() {                               // bind to mesh network on user ship.
  var path = '/web';                                    // path for network json.
  return window.urb.bind(
    path,                                               // path
    {                                                   // params
      appl: 'mesh',
      mark: 'json',
      ship: window.urb.user
    },
    function gotNetwork(error, response) {              // callback
      if (error || !response.data || response.fail) {
        console.warn('urb.bind at path `' + path + '` failed. Error: ');
        console.warn(error);
        console.warn(response);
        return;
      }
      console.log('urb.bind at path: `' + path + '` succeeded! Response data: ');
      console.log(response.data);
      drawGraph(null, response.data);
    });
}());

window.module = window.module || {};                    // eslint-disable-line no-global-assign
module.exports = {
};
