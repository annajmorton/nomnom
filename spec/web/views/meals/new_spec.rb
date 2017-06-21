require 'spec_helper'
require 'ostruct'
require_relative '../../../../apps/web/views/meals/new'

describe Web::Views::Meals::New do
  let(:params) {OpenStruct.new(valid?: false, error_messages: ['Title must be filled','Description must be filled','Photo must be filled'])}
  let(:exposures) { Hash[params: params] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/meals/new.html.erb') }
  let(:view)      { Web::Views::Meals::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when params contains erros' do
  	rendered.must_include('There was a problem with your submission')
  	rendered.must_include('Title must be filled')
  	rendered.must_include('Description must be filled')
  	rendered.must_include('Photo must be filled')
  end
end
