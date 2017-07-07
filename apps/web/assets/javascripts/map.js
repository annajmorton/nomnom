var geocoder

function initMap() {
    // Create a map object and specify the DOM element for display.
    var latlng = {lat: 29.481137, lng: -98.7945996};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: latlng,
      scrollwheel: false,
      zoom: 8
    });
}

function showFood(){

    geocoder = new google.maps.Geocoder();
	var address = document.getElementsByClassName('address').value;
	console.log(address)
	geocoder.geocode( { 'address': address}, function(results, status) {
	  if (status == 'OK') {
	    var marker = new google.maps.Marker({
	        map: map,
	        position: results[0].geometry.location
	    });
	  } else {
	    alert('Geocode was not successful for the following reason: ' + status);
	  }
	});
}