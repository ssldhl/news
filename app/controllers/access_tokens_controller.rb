class AccessTokensController < ApplicationController
  def create
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform
    render json: serializer.new(authenticator.access_token), status: :created
  end

  def destroy
    raise UserAuthenticator::AuthorizationError
  end

  private

  def serializer
    AccessTokenSerializer
  end
end
