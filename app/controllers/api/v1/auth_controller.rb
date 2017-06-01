class Api::V1::AuthController < ApplicationController

  def create
    account = Account.find_by(username: params[:username])
    if account.present? && account.authenticate(params[:password])
      ## create a JWT token that encodes the account_id and send that back as part of the response...
      token = JWT.encode({account_id: account.id}, 'hellosylvee', 'HS256')
      render json: {
        account: {
          username: account.username
        },
        token: token
      }
    else
      render json: {error: 'No account or password found'}
    end
  end
end
