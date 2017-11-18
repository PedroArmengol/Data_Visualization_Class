var margin = {top: 200, bottom: 75, left: 100, right: 100}
var width = 1100 - margin.left - margin.right;
var height = 800 - margin.top - margin.bottom;
var barPadding = 5;

//Import the data


d3.json("atf.json", function(error, data){
  if (error) { 
    console.log(error);
  } else {
    data.forEach(function(d){
      d.total = +d.Total/1000000,
      d.type = d.Type
      d.long = +d.Long_gun
    });
    dataset = data;
    console.log(dataset);
    data.sort(function(a, b) { return a.total - b.total; });
    createChart(dataset);

  };
});

var svg = d3.select("#chart")
              .append("svg")
              .attr("height", height + margin.top + margin.bottom)
              .attr("width", width + margin.left + margin.right);
//Graph
function createChart(d){
  

  var bar_width = width/dataset.length;

    //Y Scale (continuous)
    var yScale = d3.scaleLinear()
                   .domain([0, d3.max(dataset, function (d){return d.total;})])
                   .range([0, height]); 

    //X scale (categorical)
    var xScale = d3.scaleBand()
                   .domain(dataset.map(function(d) {
                             return d.type;
                           }))
                   .range([0, width])


       //Plot bars
    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function(d) {
              return margin.left + xScale(d.type);
             })
        .attr("y", margin.top)
        .attr("width", bar_width - barPadding)
        .attr("height", function(d) {
               return yScale(d.total);
             })
        .attr("class", function(d){
          if (d.long == 1){
            return "bar_long";
          } else {
            return "bar_others";
          }
        })



    //Y axis
    var yAxis = d3.axisLeft()
                  .scale(yScale)
                  .ticks(5);

    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + (margin.left-barPadding*2) + "," + margin.top + ")")
        .call(yAxis);

    //Y axis label
    svg.append("text")
        .attr("class", "axis_label")
        .text("Number of firearms (Millions)")
        .attr("transform", "translate("+ margin.left/3 +"," + (margin.top+height/2) + ") rotate(270)")
        .attr("text-anchor", "middle")

    //X axis
    var xAxis = d3.axisTop()
                  .scale(xScale);

    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + margin.left + "," + (margin.top-barPadding*2) + ")")
        .call(xAxis)
          .selectAll("text")
          .attr("transform", "translate(-70,0)")
          .style("text-anchor", "start")
          .attr("fill", "black")
          .attr("id", "x_axis_labels")


    //Title & Subtitle
    svg.append("text")
        .attr("id", "title")
        .attr("x", margin.left)
        .attr("y", margin.top/3)
        .text("Firearms production in the U.S.")

    svg.append("text")
        .attr("id", "subtitle")
        .attr("x", margin.left)
        .attr("y", margin.top/2)
        .text("Production by type: 1986-2015")

    //Add Legend
    colors = ["#35586C","#6CA6CD"]
    texts = ["Long guns", "Short guns"]

    var legend = svg.selectAll("legend")
                    .data(colors)
                    .enter().append("g");
 
    legend.append("rect")
      .attr("x", margin.left + 150)
      .attr("y", function(d, i) { return height + margin.top + 35*(i-4); })
      .attr("width", 30)
      .attr("height", 30)
      .style("fill", function(d, i) {return colors[i];});

    legend.append("text")      
      .attr("x", margin.left + 190)
      .attr("y", function(d, i) { return height + margin.top + 20 + 35*(i-4); })
      .text(function(d, i) {return texts[i];})
      .attr("class", "legend_label");

    //Caption
    svg.append("text")
       .attr("id", "caption")
       .attr("x", margin.left + 300)
       .attr("y", margin.top+height+margin.bottom-25)
       .text("Data Source: ATF U.S. Fireams Commerce Report")
       .attr("text-anchor", "middle")
    
};

