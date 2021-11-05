class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email.downcase]
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)   #neu = 1 thi goi remember(user) neu khong thi goi forget(user)
        redirect_back_or user  #chuyển hướng đến trang user
      else
        message = t("users.mess1_activation")
        flash[:warning] = message
        redirect_to root_url
      end
     
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
