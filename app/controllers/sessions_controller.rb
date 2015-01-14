class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(uid: auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to user_path(user), notice: "You've been successfully logged in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've been signed out."
  end
end
