require 'spec_helper'
require_relative '../../../../apps/web/controllers/meals/index'
require_relative '../../../upload_setup.rb'

describe Web::Controllers::Meals::Index do
  let(:action) { Web::Controllers::Meals::Index.new }
  let(:params) { Hash[] }
  let(:repository) {MealRepository.new}
  let(:provider_repo) {ProviderRepository.new}

  before do
  	repository.clear
  	provider_repo.clear
    
    photo1 = TestUploadFile::test
  	provider = provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')
  	meal = Meal.new(provider_id: provider.id, photo: photo1, title: 'Paella!', description:'some really tasty octopus paella', servings: 1, quantity: 3, pickup_location: '311 Florida Street')
    @meal = repository.create(meal)
    photo1.close

    # 1 create a signed in user 
    
  end
  

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes all meals' do 
    action.call(params)
    action.exposures[:meals].must_equal [@meal]
  end

  it 'checks to see if you are a signed in user' do
    #2 if you are signed in you get the 200
    #3 if not signed in, you get redirected to the sign-in page
 
  end 

end
