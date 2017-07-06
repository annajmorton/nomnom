module Web::Views::Meals
  class Index
    include Web::View
    
	def javascript
		raw %(<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDXjp8CSPe9-TbHvTrG-lQv9S2bJcTlpXg&callback=initMap" async defer></script>
			  <script type="text/javascript" src="/assets/map.js"></script>)
	end
  end
end
