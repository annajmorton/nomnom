require 'features_helper'

describe 'Visit home and sign into the application' do

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


	it 'successfully delivers the home page' do 
		visit '/'

		page.body.must_include('nomzster')
	end



	it 'displays list of errors when params is submitted with errors' do 
		visit '/'

		within 'form#provider-form' do
			click_button 'Post'
		end

		current_path.must_equal('/signin')

		assert page.has_content?('There was a problem with your submission')
		assert page.has_content?('Email must be filled')
		assert page.has_content?('Password must be filled')
	end

	it 'checks if email and password are registered and redirects to meals on success' do
		visit '/'

		within 'form#provider-form' do
			fill_in 'Email', with: 'test@junkjunk.com'
			fill_in 'Password', with: 'crazypass'
			
			click_button 'Post'
		end


		current_path.must_equal('/meals')

	end   

	it 'sends an error message if the email is not registered and redirects to create account' do
		visit '/'

		within 'form#provider-form' do
			fill_in 'Email', with: 'test@wrongwrong.com'
			fill_in 'Password', with: 'crazypass'
			
			click_button 'Post'
		end

		current_path.must_equal('/signup/new')
		assert page.has_content?('is not registered in our system, please create an account')

	end 

	it 'sends an error if the password does not match' do
		visit '/'

		within 'form#provider-form' do
			fill_in 'Email', with: 'test@junkjunk.com'
			fill_in 'Password', with: 'wrongwrong'
			
			click_button 'Post'
		end

		current_path.must_equal('/signin')
		assert page.has_content?('invalid password')
	end 

end
