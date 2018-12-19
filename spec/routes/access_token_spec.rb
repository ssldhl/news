require 'rails_helper'

RSpec.describe 'access token routes', type: :routing do
  it 'should route to access token create action' do
    expect(post('/login')).to route_to('access_tokens#create')
  end

  it 'should route to access token destroy action' do
    expect(delete('/logout')).to route_to('access_tokens#destroy')
  end
end