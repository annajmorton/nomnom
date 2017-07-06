module Web::Controllers::Home
	class Index
		include Web::Action

		
		def call(params)
			self.headers.merge!({ 'Content-Security-Policy' => "style-src 'self' https://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/ 'unsafe-inline'"})
		end
		
		def authenticate!
	      # no-op
	    end

	end
end