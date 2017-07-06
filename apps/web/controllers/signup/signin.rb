module Web::Controllers::Signup
  class Signin
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

    	password = params.get(:provider, :password)
        email = params.get(:provider, :email)

        if params.valid?
            repo = ProviderRepository.new
            
            if repo.find_by_email(email).nil?
                flash[:info] = "#{email} is not registered in our system, please create an account"
                redirect_to '/signup/new'
            else 
                provider = repo.check_uncrypted_password(email, password)
    
        		if provider.nil?
        			flash[:info] = "invalid password"
                    self.status = 422
        		else
        			session[:provider_id] = provider.id
                    session[:prvodier_name] = provider.name
                    flash[:info] = "you are signed in!"
                    redirect_to '/meals'
        		end 
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
