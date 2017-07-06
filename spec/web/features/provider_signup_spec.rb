require 'features_helper'
require_relative '../../upload_setup.rb'

describe 'Provider Signup' do
	let(:provider_repo) {ProviderRepository.new}
    before do 
  		provider_repo.create_crypted_with_email_password("test@junkjunk.com",'crazypass')
  	end 

	after do 
	  provider_repo.clear
	end 

	it 'created the record successfully' do
		provider_repo.last.name.must_equal 'test'
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
			fill_in 'Password confirmation', with: 'willthiseverendmyfriend'
			test = click_button 'Post' 
		end

		current_path.must_equal('/meals')
		assert page.has_content?("Hi iamhappy! your account was created successfully")
	
	end

	it 'sends you to signin if you have an account' do 
		visit '/signup/new'

		within 'form#provider-form' do

			# complete the other fields 
			fill_in 'Email', with: 'test@junkjunk.com'
			fill_in 'Password', with: 'crazypass'
			fill_in 'Password confirmation', with: 'crazypass'
			test = click_button 'Post' 
		end

		current_path.must_equal('/')
		assert page.has_content?("test@junkjunk.com already has an account. please signin here")
	end 

	it 'checks password matching' do
		visit '/signup/new'
		within 'form#provider-form' do

			# complete the other fields 
			fill_in 'Email', with: 'newtest@junkjunk.com'
			fill_in 'Password', with: 'crazypass'
			fill_in 'Password confirmation', with: 'doesnotmatch'
			test = click_button 'Post' 
		end
		assert page.has_content?('Password Confirmation must be equal to crazypass')
	end 
end


