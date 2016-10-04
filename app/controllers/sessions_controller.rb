class SessionsController < Devise::SessionsController

  def index
    super
  end

  def show
    super
  end

  def new
    if params[:user]
      user = User.find_by(email: params[:user][:email])
    end
    if user
      if user.password == params[:user][:password]
        super
      else
        super
      end
    else
      if params[:user]
        flash[:errors] = "You must create an account to sign in."
        redirect_to new_user_registration_path
      else
        super
      end
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
