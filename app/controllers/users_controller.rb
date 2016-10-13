class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.try(:admin?)
      @users = User.all.order(created_at: :asc)
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

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

  def favorite_word
    current_user.update(favorite_word_id: params[:word_id])
  end

  def remove_avatar
    user = User.find(params[:id])
    user.remove_avatar!
    user.save
    redirect_to user_path(user)
  end

  def destroy
    @user = User.find(params[:id])
    if authorized_party
      if @user.valid?
        user_valid_destroy
      else
        flash[:errors] = "User Account was not closed"
        render user_path(@user)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def authorized_party
    current_user.try(:admin?) || current_user == @user
  end

  def admin_redirect
    if current_user.admin
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def user_valid_destroy
    @user.reviews.each(&:destroy)
    @user.words.each do |word|
      word.reviews.destroy_all
    end
    @user.words.each(&:destroy)
    @user.destroy
    flash[:success] = "User Account successfully closed"
    admin_redirect
  end
end
