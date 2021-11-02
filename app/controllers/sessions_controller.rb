class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email.downcase])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user  #chuyển hướng đến trang user
    else
      flash.now[:danger] = t(".error")
      render :new
    end
  end

  def destroy
    unless log_out
      flash[:danger] = t(".error")
    end
    redirect_to root_url
  end
end
