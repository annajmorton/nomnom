require 'features_helper'
describe 'authentication not required for some pages' do
	it 'visits home page' do
		visit '/'
		page.body.must_include('nomzster')
	end 

	it 'visits signup page home page' do
		visit '/signup/new'
		page.body.must_include('nomzster')
	end

	it 'hides meals index' do
		visit '/meals'
		page.body.must_include('401')
	end

	it 'hides new meals creation' do
		visit '/meals/new'
		page.body.must_include('401')
	end
end 


describe 'authentication required for some pages' do
	let(:provider_repo) {ProviderRepository.new} 

	before :all do 
  		provider_repo.create_crypted_with_email_password("test@junkjunk.com",'crazypass')
		visit '/signup/new'

		within 'form#provider-form' do

			# complete the other fields 
			fill_in 'Email', with: 'iamhappy@stillhere.me'
			fill_in 'Password', with: 'willthiseverendmyfriend'
			test = click_button 'Post' 
		end
	end

	after :all do 
	  provider_repo.clear
	end 

	it 'visits meals index' do
		visit '/meals'
		page.body.must_include('nomzster')
	end

	it 'visits new meals' do
		visit '/meals/new'
		page.body.must_include('nomzster')
	end
end
