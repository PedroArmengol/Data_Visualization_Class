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
    //createChart(dataset);

  };
});

