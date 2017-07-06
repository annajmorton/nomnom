function initMap() {
    // Create a map object and specify the DOM element for display.
    var latlng = {lat: -25.363, lng: 131.044};
    var map = new google.maps.Map(document.getElementById('map'), {
      center: latlng,
      scrollwheel: false,
      zoom: 8
    });
  	var marker = new google.maps.Marker({
      position: latlng,
      map: map
    })
}

   

function codeAddress() {
	// var address = document.getElementById('address').value;
	var address = '14331 Hill Prince San Antonio, Tx 78248'
	geocoder.geocode( { 'address': address}, function(results, status) {
	  if (status == 'OK') {
	    map.setCenter(results[0].geometry.location);
	    var marker = new google.maps.Marker({
	        map: map,
	        position: results[0].geometry.location
	    });
	  } else {
	    alert('Geocode was not successful for the following reason: ' + status);
	  }
	});
}