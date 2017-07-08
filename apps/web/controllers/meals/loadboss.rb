module Web::Controllers::Meals
  class Loadboss
    include Web::Action
    accept :json


    def call(params)
     
      meals = MealRepository.new.last
      # loop through and hash each then save
      self.body = JSON.generate(meals.to_h)

    end
    
  end
end
