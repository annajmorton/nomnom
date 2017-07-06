require 'spec_helper'
require_relative '../../../../apps/web/views/meals/index'
require_relative '../../../upload_setup.rb'


describe Web::Views::Meals::Index do

  let(:exposures) { Hash[meals: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/meals/index.html.erb') }
  let(:view)      { Web::Views::Meals::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #meals' do
   view.meals.must_equal exposures.fetch(:meals)
  end

  describe 'when there are no meals' do
    it 'shows a placeholder message' do
      rendered.must_include('<p class="placeholder"> We are out of meals.</p>')
    end
  end

  describe 'where there are meals' do
    
    provider_repo = ProviderRepository.new
    provider_repo.clear
    provider = provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')
    
    repository = MealRepository.new()

    photo1 = TestUploadFile::test
    meal1 = Meal.new(provider_id: provider.id, photo: photo1, title: 'Paella!', description:'some really tasty octopus paella', servings: 1, quantity: 3, pickup_location: '311 Florida Street')
    meal1 = repository.create(meal1)
    photo1.close
    
    photo2 = TestUploadFile::test
    meal2 = Meal.new(provider_id: provider.id, photo: photo2, title: 'FavorFav', description:'McDonals because Tremon loves it', servings: 1, quantity: 10000, pickup_location: '101 Alamo Plaza')
    meal2 = repository.create(meal2)
    photo2.close

    let(:meal1) {mealA}
    let(:meal2) {mealB}

    let(:exposures) {Hash[meals: [meal1, meal2]]}


    it 'lists them all' do
      rendered.scan(/class="meal"/).count.must_equal 2
      rendered.must_include('octopus paella')
      rendered.must_include('Tremon loves it') 
    end


    it 'hides the placeholder message' do
      rendered.wont_include('<p class="placeholder"> We are out of meals.</p>')
    end 

    it 'shows the map' do 
      rendered.must_include('Here is the map')
    end

  end 

end
