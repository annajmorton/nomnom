require 'spec_helper'
require_relative '../../../../apps/web/views/home/index'

describe Web::Views::Home::Index do
  let(:params) {OpenStruct.new(valid?: false, error_messages:['Email must be filled', 'Password must be filled'])}
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Signup::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'tests the correct view' do
  	rendered.must_include('sign in to the most sustainable food group')
  end 

  it 'sign in --- displays list of errors when user params contains erros' do
    rendered.must_include('There was a problem with your submission')
    rendered.must_include('Email must be filled')
    rendered.must_include('Password must be filled')
  end

end
