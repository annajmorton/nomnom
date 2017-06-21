require 'spec_helper'
require_relative '../../../../apps/web/controllers/signup/signin'

describe Web::Controllers::Signup::Signin do
  let(:action) { Web::Controllers::Signup::Signin.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 302
  end
end
