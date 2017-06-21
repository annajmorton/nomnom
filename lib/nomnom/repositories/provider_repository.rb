class ProviderRepository < Hanami::Repository

	associations do
		has_many :credentials
	end

	def create_with_credentials(data)
		assoc(:credentials).create(data)
	end

	def auth!(auth_hash)
		info = auth_hash[:info]
		external_id = auth_hash[:uid]
		service_provider = auth_hash[:service_provider]
		attrs = {
		 name:   info[:name],
		 email:  info[:email],
		}

		user = aggregate(:credentials).join(:credentials).
		        where(external_id: external_id, service_provider: service_provider).
		        one

		if user
		  update(user.id, attrs)
		else
		  create_with_credentials(attrs.merge(
		    credentials: [{external_id: external_id, service_provider: service_provider}]
		  ))
		end
	end
	def find_by_credentials(provider_params, password)
	  conditions = { email: provider_params[:auth_key], credentials__provider: 'self' }
	  provider = aggregate(:credentials).join(:credentials).where(conditions).as(Provider).one
	  if provider && provider.credentials.first && SCrypt::Password.new(provider.credentials.first.crypted_password) == password
	    provider
	  else
	    nil
	  end
	end

end
