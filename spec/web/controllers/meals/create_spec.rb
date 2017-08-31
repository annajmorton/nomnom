require 'spec_helper'
require_relative '../../../../apps/web/controllers/meals/create'
require_relative '../../../upload_setup.rb'

describe Web::Controllers::Meals::Create do
  let(:action) { Web::Controllers::Meals::Create.new }
  let(:repository) {MealRepository.new}
  let(:provider_repo) {ProviderRepository.new}

  before :each do 
    repository.clear
    provider_repo.clear
    provider = provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')

    # photo upload removed
    # photo1 = TestUploadFile::test
    params1 = Hash[meal: {provider_id: provider.id, photo: '', title: 'Good Stuff', description:'this is amazing!', servings: 100, quantity: 3, pickup_location: '1443 South Saint Marys'}]

    # photo upload removed
    # photo2 = TestUploadFile::test
    params2 = Hash[meal: {provider_id: provider.id, photo: '', title: 'Good Stuff', description:'this is amazing!', servings: 100, quantity: 3, pickup_location: '1443 South Saint Marys'}]
  
  end

  after :all do 
    Provider_repo.clear
  end 

  after :each do
    MealRepository.new.clear
  end

  describe 'with valid params' do
    
    it 'creates a new meal' do
      action.call(params1)
      meal = repository.last
      meal.id.wont_be_nil
      meal.title.must_equal params1.dig(:meal, :title)
      photo1.close
    end

    it 'redirects the user to the meals listing' do
      response = action.call(params2)

      response[0].must_equal 302
      response[1]['Location'].must_include '/meals'
      photo2.close
    end

  end

  describe 'with invalid params' do
    let(:params) {Hash[meal: {}]}

    it 'returns HTTP client error' do
      response = action.call(params)
      response[0].must_equal 422
    end

    it 'dumps errors in params' do 
      action.call(params)
      errors = action.params.errors

      errors.dig(:meal, :title).must_equal ['is missing']
      errors.dig(:meal, :description).must_equal ['is missing']
      # photo upload disabled
      # errors.dig(:meal, :photo).must_equal ['is missing',"size must be within 1 - 5242880"]
      errors.dig(:meal, :servings).must_equal ['is missing']
      errors.dig(:meal, :quantity).must_equal ['is missing']
      errors.dig(:meal, :pickup_location).must_equal ['is missing']
    end 
  
  end

  it 'checks to see if you are a signed in user' do
    #2 if you are signed in you get the 200
    #3 if not signed in, you get redirected to the sign-in page
  end 

end
