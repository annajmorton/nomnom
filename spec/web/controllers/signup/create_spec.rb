require 'spec_helper'
require_relative '../../../../apps/web/controllers/signup/create'

describe Web::Controllers::Signup::Create do
  let(:action) { Web::Controllers::Signup::Create.new }
  let(:repository) {ProviderRepository.new}
  let(:cred_repo) {CredentialRepository.new}

  before :all do 
  	repository.clear
    cred_repo.clear
  end

  describe 'with valid provider params' do
  	let(:params) { Hash[provider: { email: "test@greatwork.com", password: "partypartyparty", password_confirmation: "partypartyparty"}] }

	  it 'creates a new provider' do
	  	action.call(params)
	  	
      provider = repository.last
      cred = cred_repo.last

      provider.id.wont_be_nil
	  	provider.email.must_equal params.dig(:provider, :email)

	  end

    it 'creates authentication' do
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

end
