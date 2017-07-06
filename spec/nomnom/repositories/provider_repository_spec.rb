require 'spec_helper'

describe ProviderRepository do
  let(:provider_repo) {ProviderRepository.new}
	 
  before do 
  	provider_repo.create_crypted_with_email_password("test@junkjunk.com",'crazypass')
  end 
  after do 
  	provider_repo.clear
  end 


  it 'creates a crypted provider with email and password' do
  	provider_repo.last.email.must_equal 'test@junkjunk.com'
  end

  it 'can check if an email is registered' do
  	provider_repo.find_by_email('test@junkjunk.com').name.must_equal 'test'
  	provider_repo.find_by_email('bad@badbad.com').must_equal nil
  end

  it 'can check email/password combination and return provider' do 
  	
  	provider1 = provider_repo.check_uncrypted_password('test@junkjunk.com', 'crazypass')
  	provider1.id.must_equal provider_repo.last.id

  	provider_repo.check_uncrypted_password('test@junkjunk.com', 'badpass').must_be_nil
  
  end

end
