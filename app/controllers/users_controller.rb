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
end
