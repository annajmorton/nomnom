require 'features_helper'
require_relative '../../upload_setup.rb'

describe 'Add a meal' do
	let(:provider_repo) {ProviderRepository.new}
    let(:provider) {provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')}
	
	after :all do 
		Provider_repo.clear
	end 

	after :each do
		MealRepository.new.clear
	end

	it 'displays list of errors when params contains errors' do 
		visit '/meals/new'

		within 'form#meal-form' do
			click_button 'Post'
		end

		current_path.must_equal('/meals')

		assert page.has_content?('There was a problem with your submission')
		assert page.has_content?('Title must be filled')
		assert page.has_content?('Description must be filled')
		assert page.has_content?('Photo is missing')
	end 

	it 'can create a new meal' do
		visit '/meals/new'

		within 'form#meal-form' do
			
			tfile = TestUploadFile::test
			if File::exists?(tfile) 
				attach_file 'Photo', tfile.path
			end 


			# complete the other fields 
			fill_in 'Title', with: 'test meal'
			fill_in 'Description', with: 'something really really yummy'
			fill_in 'Servings', with: 1
			fill_in 'Quantity', with: 2
			fill_in 'Pickup Location', with: '1443 South Saint Marys'
			fill_in	'Provider Id', with: provider.id
			

			test = click_button 'Post' 
			tfile.close
		end

		current_path.must_equal('/meals')
		assert page.has_content?('test meal')
	
	end
end


