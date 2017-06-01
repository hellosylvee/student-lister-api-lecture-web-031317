class Api::V1::AuthController < ApplicationController
  def create
    account = Account.find_by(username: params[:username])
    if account.present? && account.authenticate(params[:password])
      render json: account
    else
      render json: {error: 'Error'}
    end
  end
end
