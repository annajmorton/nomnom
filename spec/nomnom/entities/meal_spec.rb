require 'spec_helper'

describe Meal do 
	it 'can be initialized with attributes' do
		meal = Meal.new(description: 'wow so yummy yummy')
		meal.description.must_equal 'wow so yummy yummy'
	end
end
