require 'spec_helper'
require_relative '../../../../apps/web/controllers/meals/loadboss'

# as written, AUTHENTICATION MUST BE REMOVED from the action for this test to pass

describe Web::Controllers::Meals::Loadboss do
  let(:action) { Web::Controllers::Meals::Loadboss.new }
  let(:params) {Hash[]}
  let(:repository) {MealRepository.new}
  let(:pro_repo) {ProviderRepository.new}
  
  before :all do
	  provider = pro_repo.create(email:"test@junkjunk.com", password: 'crazypass')
	  repository.create(Meal.new(provider_id: provider.id, photo:'', title: 'Paella!', description:'some really tasty octopus paella', servings: 1, quantity: 3, pickup_location: '311 Florida Street, San Antonio Tx, 78210'))
	  repository.create(Meal.new(provider_id: provider.id, photo:'', title: 'FavorFav', description:'McDonals because Tremon loves it', servings: 1, quantity: 10000, pickup_location: '101 Alamo Plaza, San Antonio Tx, 78205'))
  end 
  
  after :all do
  	repository.clear
  	pro_repo.clear
  end 


  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
  it 'returns all the meals for geocoding with google maps'do
  	meals = repository.last
  	response = action.call(params)
    response[2].must_equal ["#{meals.to_h}"]
  end 
end
