class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @default_image = "Man_Silhouette.jpg"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.avatar = params[:user][:avatar]
    user.save
    redirect_to user_path(user)
  end

  def remove_avatar
    user = User.find(params[:id])
    user.remove_avatar!
    user.save
    redirect_to user_path(user)
  end
end
