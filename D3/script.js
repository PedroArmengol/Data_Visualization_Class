			  


			  function rowConverter(d) {
			  	return {
			  		type: d.Type,
			  		total: +d.Total
		
			  	};

			  }

			  d3.csv("atf.csv", rowConverter, function(data) {

			  	data.sort(function(a, b) { return a.total - b.total; });

			  	var dataset = data;

			  	console.log(dataset);

			  	createChart(dataset);



			  });

 				
				 

			  function createChart(dataset) {
			  	var width = 1000;
			  	var height = 500;
			  	var marginleft = 20;
			  	var marginright = 20;
			  	var margintop = 20;
			  	var marginbottom = 20;
			  	var bar_padding = 1;


			  	console.log("hello")

			  	var xScale = d3.scaleBand()
						.domain(dataset.map(function (d) { return d.type; }))
						.rangeRound([0, width])
						.paddingInner(0.4)
						.align(0.1);

			  	var yScale = d3.scaleLinear()
			  					.domain([
			  						d3.min(dataset,function(d) {return d.total;}),
			  						d3.max(dataset,function(d) {return d.total;})
			  						])
			  					.range([height-marginbottom,margintop]);
			  		

			  	var svg = d3.select("#chart")
			  				.append("svg")
			  				.attr("width",width)
			  				.attr("height",height);

			  	var xaxis = svg.append("g")
			  		.attr("transform","translate(0,"+(height-marginbottom)+")")
			  		.call(d3.axisBottom(xScale));
			  		
			  	var yaxis = svg.append("g")
			  		.attr("transform","translate("+(marginleft)+",0)")
			  		.call(d3.axisLeft(yScale));	

			  	
			//Bar chart

			  svg.selectAll("rect")
				.data(dataset)
				.enter()
				.append("rect")
				.attr("x", function(d,i) {

					return i*(width/dataset.length) +25; // 

				})
				.attr("y", -40)
				.attr("width", width/dataset.length - bar_padding)
				.attr("height", function(d) {

					return d.total/70000;
				})
				.attr("fill", function(d) { //Color of different insentity
					return "rgb(" + Math.round(d.total/100000) + ", 0, 0)";

				});


			  }