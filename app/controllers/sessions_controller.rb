class SessionsController < Devise::SessionsController
  def index
    super
  end

  def show
    super
  end

  def new
    user = User.find_by(email: params[:user][:email]) if params[:user]

    if params[:user] && !user
      flash[:errors] = "You must create an account to sign in."
      redirect_to new_user_registration_path
    else
      super
    end
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end
