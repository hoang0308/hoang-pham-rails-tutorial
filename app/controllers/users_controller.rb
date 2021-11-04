class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
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

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update(user_params)
      flash[:success] = t(".fl_success")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t(".flash_delete")
    redirect_to users_url
  end
  

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :age, :gender)
      # tra ve 1 version params hash voi cac attributes trong permit
      # va se phat sinh error neu :user attribute loi
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t("flash_pl_login")
        redirect_to login_url unless current_user?(@user)
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
