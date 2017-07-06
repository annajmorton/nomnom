class ProviderRepository < Hanami::Repository

	associations do
		has_many :credentials
	end

	def create_with_credentials(data)
		assoc(:credentials).create(data)
	end

	def create_crypted_with_email_password(email, password)
        crypted_password = SCrypt::Password.create(password, :max_time => 0.005)

        # create name from email
        name = email.sub(/@.*/,'')

        repo = ProviderRepository.new
        repo.create_with_credentials(
          email: email,
          name: name,
          credentials: [{ crypted_password: crypted_password, provider: 'self' }]
        )
	end 

	def find_by_email(email)
	  providers.where(email: email).first
	end

	def check_uncrypted_password(email, password)
	  conditions = { email: email, credentials__provider: 'self' }
	  provider = aggregate(:credentials).join(:credentials).where(conditions).as(Provider).first
	  if provider.credentials.first && SCrypt::Password.new(provider.credentials.first.crypted_password) == password
	  	provider
	  else
	    nil
	  end
	end 
end
