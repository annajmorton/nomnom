require 'scrypt'

module Web::Controllers::Signup
  class Create
    include Web::Action
    include Hanami::Validations::Form

    expose :provider

    params do
      required(:provider).schema do
        required(:email).filled(:str?, format?: /@/)
        required(:password).filled(:str?)
      end 
    end


    def call(params)
      
    	if params.valid?
	    	provider_params = params[:provider]
        password = SCrypt::Password.create(provider_params[:password], :max_time => 0.005)

        repo = ProviderRepository.new
        repo.create_with_credentials(
          email: provider_params[:email],
          name: provider_params[:name],
          credentials: [{ crypted_password: password, provider: 'self' }]
        )

        cred = CredentialRepository.new.last
        password2 = SCrypt::Password.new(cred.crypted_password)

        redirect_to '/meals'
    	else 
    		self.status = 422
    	end 
    end

  end
end
