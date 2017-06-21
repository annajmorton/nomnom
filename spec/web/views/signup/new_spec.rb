require 'spec_helper'
require_relative '../../../../apps/web/views/signup/new'

describe Web::Views::Signup::New do
  let(:params) {OpenStruct.new(valid?: false, error_messages:['Email must be filled', 'Password must be filled'])}
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/signup/new.html.erb') }
  let(:view)      { Web::Views::Signup::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when user params contains erros' do
    rendered.must_include('There was a problem with your submission')
    rendered.must_include('Email must be filled')
    rendered.must_include('Password must be filled')
    
  end
end