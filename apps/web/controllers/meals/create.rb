module Web::Controllers::Meals
  class Create
    include Web::Action
    include Hanami::Validations::Form
    
    MEGABYTE = 1024 ** 2

    expose :meal

    params do
    	required(:meal).schema do
    		required(:title).filled(:str?)
    		required(:description).filled(:str?)
    		required(:photo).filled(size?: 1..(MEGABYTE * 5))
            required(:pickup_location).filled(:str?)
            required(:servings).filled(:int?)
            required(:quantity).filled(:int?)
    		required(:provider_id).filled(:int?)
    	end
    end


    def call(params)

        if params.valid?

            params.get(:meal,:photo).kind_of? Hash and
                params.get(:meal, :photo).has_key? :tempfile and
                params[:meal][:photo] = params.get(:meal, :photo, :tempfile)
            
            meal = Meal.new(params.get(:meal))
            @meal = MealRepository.new.create(meal)
            
            redirect_to '/meals'
        else
    		self.status = 422
    	end
    end
  end
end
