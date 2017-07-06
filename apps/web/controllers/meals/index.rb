module Web::Controllers::Meals
  class Index
    include Web::Action

    expose :meals

    def call(params)
    	@meals = MealRepository.new.all
    end
    
  end
end
