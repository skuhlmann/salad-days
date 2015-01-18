class UsersController < ApplicationController

  def show
    require_user
    @user = User.find(params[:id])
  end

  private

  def require_user
    unless current_user && current_user.id.to_s == params[:id]
      flash[:notice] = "Unauthorized"
      redirect_to root_path
    end
  end
end
