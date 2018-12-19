require 'rails_helper'

RSpec.describe 'access token routes', type: :routing do
  it 'should route to access token create action' do
    expect(post('/login')).to route_to('access_tokens#create')
  end
end