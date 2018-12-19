require 'rails_helper'

shared_examples_for 'unauthorized_requests' do
  let(:authentication_error) do
    {
      'status' => '401',
      'source' => { 'pointer' => '/code' },
      'title' => 'Authentication code is invalid',
      'detail' => 'You must provide valid code in order to exchange it for token.'
    }
  end

  it 'should have unauthorized status code' do
    subject
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should return proper error body' do
    subject
    expect(json['errors']).to include(authentication_error)
  end
end

shared_examples_for 'forbidden_requests' do
  let(:authorization_error) do
    {
      'status' => '403',
      'source' => { 'pointer' => '/headers/authorization' },
      'title' => 'Not authorized',
      'detail' => 'You have no right to access this resource.'
    }
  end

  it 'should return forbidden status code' do
    subject
    expect(response).to have_http_status(:forbidden)
  end

  it 'should return proper error body' do
    subject
    expect(json['errors']).to include(authorization_error)
  end
end