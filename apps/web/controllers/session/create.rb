module Web::Controllers::Session
  class Create
    include Web::Action
    
    def auth_hash
      request.env["omniauth.auth"]
    end

    def call(params)
      user = ProviderRepository.new.auth!(auth_hash)
      warden.set_provider provider
      redirect_to '/meals'
    end

    def warden
      request.env['warden']
    end
  end
end