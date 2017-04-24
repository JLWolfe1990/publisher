class UsersController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def subscribe
    email = params.fetch(:user).fetch(:email)
    User.invite! email: email

    cookies[:user_email] = email

    redirect_to request.referer
  end
end
