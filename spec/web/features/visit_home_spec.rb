require 'features_helper'

describe 'Visit home' do
	it 'is successful' do 
		visit '/'

		page.body.must_include('nomzster')
	end

	it 'has a signin form that posts to the right spot' do
		visit '/'

		within 'form#provider-form' do
			click_button 'Post'
		end

		current_path.must_equal('/meals')

	end 

	# it 'displays list of errors when params contains errors' do 
	# 	visit '/signup/new'

	# 	within 'form#provider-form' do
	# 		click_button 'Post'
	# 	end

	# 	current_path.must_equal('/signup')

	# 	assert page.has_content?('There was a problem with your submission')
	# 	assert page.has_content?('Email must be filled')
	# 	assert page.has_content?('Password must be filled')
	# end 
end
