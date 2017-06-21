require 'features_helper'
require_relative '../../upload_setup.rb'

describe 'List meals' do
	let(:repository) {MealRepository.new}
	let(:provider_repo) {ProviderRepository.new}
	
	
	before do

		repository.clear
		provider_repo.clear

		provider = provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')
		
		photo1 = TestUploadFile::test
		meal1 = Meal.new(provider_id: provider.id, photo: photo1, title: 'Paella!', description:'some really tasty octopus paella', servings: 1, quantity: 3, pickup_location: '311 Florida Street')
		repository.create(meal1)
		photo1.close
		
		photo2 = TestUploadFile::test
		meal2 = Meal.new(provider_id: provider.id, photo: photo2, title: 'FavorFav', description:'McDonals because Tremon loves it', servings: 1, quantity: 10000, pickup_location: '101 Alamo Plaza')
		repository.create(meal2)
		photo2.close
	end


	it 'displays each meal on the page' do
		visit '/meals'

		within '#meals' do
			assert page.has_css?('.meal', count:2), 'Expected to find 2 meals'
		end
	end

end
