require 'spec_helper'
require_relative '../../../../apps/web/controllers/signup/signin'

describe Web::Controllers::Signup::Signin do
  let(:action) { Web::Controllers::Signup::Signin.new }
  let(:params) { Hash[provider: { email: "test@greatwork.com", password: "partypartyparty"}] }
  let(:repository) {ProviderRepository.new}
  # let(:cred_repo) {CredentialRepository.new}

  before :all do 
  	
  end

  after :all do 
	repository.clear
    # cred_repo.clear
  end 

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 302
  end
end

