require 'features_helper'
require_relative '../../upload_setup.rb'

describe 'Provider Signup' do
	let(:provider_repo) {ProviderRepository.new}
    let(:provider) {provider_repo.create(email:"test@junkjunk.com", password: 'crazypass')}
	
	after :each do 
		provider_repo.clear
	end 

	it 'displays list of errors when params contains errors' do 
		visit '/signup/new'

		within 'form#provider-form' do
			click_button 'Post'
		end

		current_path.must_equal('/signup')

		assert page.has_content?('There was a problem with your submission')
		assert page.has_content?('Email must be filled')
		assert page.has_content?('Password must be filled')
	end 

	it 'can create a new provider' do
		visit '/signup/new'

		within 'form#provider-form' do

			# complete the other fields 
			fill_in 'Email', with: 'iamhappy@stillhere.me'
			fill_in 'Password', with: 'willthiseverendmyfriend'
			test = click_button 'Post' 
		end

		current_path.must_equal('/meals')
		# assert session is active, user is logged in
	
	end
end


