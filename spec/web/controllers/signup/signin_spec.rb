require 'spec_helper'
require_relative '../../../../apps/web/controllers/signup/create'

describe Web::Controllers::Signup::Create do
  let(:action) { Web::Controllers::Signup::Create.new }
  let(:repository) {ProviderRepository.new}
  let(:cred_repo) {CredentialRepository.new}
  let(:provider) {ProviderRepository.create( email: "test@greatwork.com", password: "partypartyparty")}

  before :all do 
  	repository.clear
    cred_repo.clear


  end

  describe 'with valid provider params' do 
  	let(:params) { Hash[provider: { email: "test@greatwork.com", password: "partypartyparty"}] }

    it 'checks authentication' do
      action.call(params)
      
      provider = repository.last
      cred = cred_repo.last

      cred.provider_id.must_equal provider.id

      password = SCrypt::Password.new(cred.crypted_password)
      assert_equal(password, params.dig(:provider, :password))

    end 

	  it 'redirects the user to the meals listing' do
	  	response = action.call(params)

	  	response[0].must_equal 302
	  	response[1]['Location'].must_include '/meals'
	  end 	
	  
  end 

  describe 'with invalid params' do
      let(:params) {Hash[provider: {invalid: "this param shouldnt pass"}]}

      it 'returns HTTP client error' do
        response = action.call(params)
        response[0].must_equal 422
      end

      it 'dumps errors in params' do 
        action.call(params)
        errors = action.params.errors

        errors.dig(:provider, :email).must_equal ['is missing']
        errors.dig(:provider, :password).must_equal ['is missing']
      end 

      it 'whitelists only the accepted params' do 
        action.call(params)
        action.params[:provider].must_equal({})
      end 
  end 

  describe 'with unregistered user' do
    let(:params) {Hash[provider: {email:"bad@bademail.com", password:"wrong password" }]}
    
    it 'notes the user email is unregistered' do
      response = action.call(params)
      response[0].must_equal 422

      errors = action.params.errors      
      errors.dig(:provider, :email).must_equal ['#{params[:provider][:email]} is not registered with us, please create an account']
    end 

  end 


end
