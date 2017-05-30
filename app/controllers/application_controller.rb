class ApplicationController < ActionController::API

  private

  def authorize_account!
    unless current_account
      render json: { error: "Not Authorized" }
    end
  end

  def current_account
    if token.present?
      decoded = decode(token)
      @current_account ||= Account.find_by( id: decoded.first['account_id'] )
    end
  end

  def decode(token)
    JWT.decode token, ENV['JWT_SECRET'], { :algorithm => ENV['JWT_ALOGIRTHM'] }
    rescue JWT::DecodeError
       [{}]
  end

  def token
    request.headers['token']
  end
end
