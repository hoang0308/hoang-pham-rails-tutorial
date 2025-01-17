class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
 
  
  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t(".flash_activation")
      redirect_to root_url   # ~ redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t(".fl_success")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t(".flash_delete")
    redirect_to users_url
  end

  def send_user
    @users = User.all
    UserMailer.users_information(@users).deliver_now
    redirect_to root_url
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
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to root_url unless @user.current_user?(current_user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def find_user
      @user = User.find_by id: params[:id]
      if @user.nil?
        flash.now[:alert] = t("users.error_no_find")
        render "static_pages/home"
      end
    end

end
