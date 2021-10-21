class UsersController < ApplicationController
  def show
    # begin
    #   @user = User.find(params[:id])
    # rescue ActiveRecord::RecordNotFound => exception
    #   flash[:success] = "User not found"  
    #   render "static_pages/home"    #neu khong tim thay id se tra ve trang home
    # end

    if(User.find_by_id(params[:id]).nil?)
      flash.now[:alert] = "User not found"
      render "static_pages/home"
    else
      @user = User.find(params[:id])
      # redirect_to @user
    end
    # debugger
  end
  
  def new
    @user = User.new
  end
  def create
    # @user = User.new(params[:user]) # not the final implementation
    @user = User.new user_params
    if @user.save
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
