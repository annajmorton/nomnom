module Web::Controllers::Signup
  class Signin
    include Web::Action

    def call(params)
    	redirect_to '/meals'
    end
  end
end
