module Web
  module Authentication
    def self.included(action)
      action.class_eval do
        before :authenticate!
        expose :provider
      end
    end

    private

    def authenticate!
      halt 401 unless authenticated?
    end

    def authenticated?
      !!current_provider
    end

    def current_provider
      @current_provider ||= ProviderRepository.new.find(session[:provider_id])
    end
  end
end