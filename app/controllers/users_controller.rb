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
  end

  def destroy
    @user = User.find(params[:id])
    if authorized_party
      if @user.valid?
        @user.reviews.delete_all
        @user.words.each do |word|
          word.reviews.delete_all
        end
        @user.words.delete_all
        @user.delete
        flash[:success] = "User Account successfully closed"
        admin_redirect
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
end
