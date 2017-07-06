require 'scrypt'

module Web::Controllers::Signup
  class Create
    include Web::Action
    include Hanami::Validations::Form

    expose :provider

    params do
      required(:provider).schema do
        required(:email).filled(:str?, format?: /@/)
        required(:password).filled(:str?).confirmation
      end 
    end


    def call(params)
      
    	if params.valid?
        repo = ProviderRepository.new
	    	provider_params = params[:provider]
      
        if repo.find_by_email(provider_params[:email]).nil?
          provider = repo.create_crypted_with_email_password(provider_params[:email],provider_params[:password])
          
          session[:provider_id] = provider.id
          session[:prvodier_name] = provider.name
          
          flash[:info] = "Hi #{provider.name}! your account was created successfully and we signed you in!"
          redirect_to '/meals'
        else    
          flash[:info] = "#{provider_params[:email]} already has an account. please signin here"
          redirect_to '/'
        end
       
    	else 
    		self.status = 422
    	end 
    end

    def authenticate!
      # no-op
    end

  end
end
