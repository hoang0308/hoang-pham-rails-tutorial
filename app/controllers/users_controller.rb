class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    if(@user.nil?)
      flash.now[:alert] = "User not found"
      render "static_pages/home"
    end
  # debugger
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user   # ~ redirect_to user_url(@user)
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :age, :gender)
      # tra ve 1 version params hash voi cac attributes trong permit
      # va se phat sinh error neu :user attribute loi
    end

end
