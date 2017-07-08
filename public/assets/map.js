var geocoder
var map

function initMap() {
    // Create a map object and specify the DOM element for display.
    var latlng = {lat: 29.481137, lng: -98.7945996};

    map = new google.maps.Map(document.getElementById('map'), {
      center: latlng,
      scrollwheel: false,
      zoom: 8
    });
}

$(showFood)

function showFood(geocodeAddy){
	var meals
	var	address
	
	$.get("/meals/loadboss", function(data, status){
	  if (status == 'success') {
	  	console.log("Data: " + data);
		meals = JSON.parse(data);
		
		// at some point, this function needs to be updated for more than one location
		address = meals.pickup_location;
		console.log(meals);
		console.log(meals.pickup_location);
	    
	  } else {
	    alert('loadboss for meals was not successful for the following reason: ' + status);
	  }
	}).done(function(){

		console.log("this is running")
	    geocoder = new google.maps.Geocoder();
		console.log(address)
		geocoder.geocode( { 'address': address}, function(results, status) {
		  if (status == 'OK') {
		    var marker = new google.maps.Marker({
		        map: map,
		        position: results[0].geometry.location
		    });

		    var contentString = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '</div>'+
			      '<h2 id="firstHeading" class="firstHeading">'+ meals.title +'</h2>'+
			      '<div id="bodyContent">'+
			      '<p>'+ meals.description + '</p>'+
			      '<p>Quantity/Servings: '+ meals.quantity +'/'+ meals.servings+'</p>'+
			      '<p>Pickup Location: '+ meals.pickup_location + '</p>'+
			      '</div>'+
			      '</div>';

		  	var infowindow = new google.maps.InfoWindow({
		    	content: contentString
		  	});

		  	marker.addListener('click', function() {
		    	infowindow.open(map, marker);
		  	});


		    console.log(results)
		  } else {
		    console.log('Geocode was not successful for the following reason: ' + status);
		  }
		});

	});
    
}

function geocodeAddy(address){
	console.log("this is running")
    geocoder = new google.maps.Geocoder();
	console.log(address)
	geocoder.geocode( { 'address': address}, function(results, status) {
	  if (status == 'OK') {
	    var marker = new google.maps.Marker({
	        map: map,
	        position: results[0].geometry.location
	    });
	    console.log(results)
	  } else {
	    console.log('Geocode was not successful for the following reason: ' + status);
	  }
	});
}