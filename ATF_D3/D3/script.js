var margin = {top: 200, bottom: 75, left: 100, right: 100}
var width = 1100 - margin.left - margin.right;
var height = 800 - margin.top - margin.bottom;
var barPadding = 5;

//Import the data


d3.csv("merchants_state.csv", function(error, data){
  if (error) { 
    console.log(error);
  } else {
    data.forEach(function(d){
      d.lon = +d.lon,
      d.lat = +d.lat,
      d.year = +d.year,
      d.type = +d.type,
      d.name = d.license_name
    });
    dataset = data;
    console.log(dataset);
    createChart(dataset);

  };
});

var svg = d3.select("body")
              .append("svg")
              .attr("height", height + margin.top + margin.bottom)
              .attr("width", width + margin.left + margin.right);
//Graph
function createChart(d){

  //Y Scale (continuous)
    var yScale = d3.scaleLinear()
                   .domain([d3.min(dataset, function (d){return d.lat;}), d3.max(dataset, function (d){return d.lat;})])
                   .range([height,0]); 

    //X scale (categorical)
    var xScale = d3.scaleLinear()
                   .domain([d3.min(dataset, function (d){return d.lon;}), d3.max(dataset, function (d){return d.lon;})])
                   .range([0, width])

 //Draw the scatter plot
  svg.selectAll("circle")
    .data(dataset)
    .enter()
    .append("circle")
    .attr("cx", function(d) {
      return xScale(d.lon);
    })
    .attr("cy",function(d){
      return yScale(d.lat);
    })
    .attr("r", 5)
    .attr("class", function(d){

          if (d.year == 2014){

            return "point_2014";

          if (d.year == 2015)

            return "point_2015";

          if (d.year == 2016)

            return "point_2016";

          } else {

            return "point_2017";

            }
          
        });

    //Y axis
    var yAxis = d3.axisLeft()
                  .scale(yScale)
                  .ticks(10);

    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + (margin.left-barPadding*2) + "," + margin.top + ")")
        .call(yAxis);

    //Y axis label
    svg.append("text")
        .attr("class", "axis_label")
        .text("Latitude")
        .attr("transform", "translate("+ margin.left/3 +"," + (margin.top+height/2) + ") rotate(270)")
        .attr("text-anchor", "middle");

    //X axis
    var xAxis = d3.axisBottom()
                  .scale(xScale)
                  .ticks(10);
 
    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + margin.left + "," + (margin.top+height+barPadding*2) + ")")
        .call(xAxis);

    //X axis label
    svg.append("text")
        .attr("class", "axis_label")
        .text("Longitude")
        .attr("transform", "translate("+ (margin.left + width/2) +"," + (margin.top+height+barPadding*12) + ")")
        .attr("text-anchor", "middle");


  
   
  };