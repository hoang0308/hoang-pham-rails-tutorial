class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by email: params[:email]
        if user && !user.active? && user.authenticated?(:activation, params[:id])
            user.update_status
            log_in user
            flash[:success] = t("users.fl_success_activation")
            redirect_to user
        else
            flash[:danger] = t("users.fl_danger_activation")
            redirect_to root_url
        end
    end
    
end
