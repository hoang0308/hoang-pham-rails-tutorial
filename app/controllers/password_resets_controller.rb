class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_mail
      flash[:info] = t(".fl_reset_success")
      redirect_to root_url
    else
      flash[:danger] = t(".fl_reset_error")
      redirect_to root_url
    end
  end

  def update
    if params[:user][:password.empty?]
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t("users.fl_reset_success")
      redirect_to @user
    else
      render :edit
    end
  end

  def edit
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def get_user
      @user = User.find_by email: params[:email]
    end

    def valid_user
      unless @user && @user.active? && @user.authenticated?(:reset, params[:id])
        flash[:danger] = t("users.fl_reset_error")
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = t("users.error_expired")
        redirect_to new_password_reset_url
      end
    end
  
end
