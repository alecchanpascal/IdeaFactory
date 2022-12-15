class UsersController < ApplicationController
    def new 
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
        if @user.save
            session[:user_id] = @user.id
            flash[:Notice] = "Logged In!"
            redirect_to root_path
        else
            flash[:Error] = @user.errors.full_messages.to_sentence
            render :new
        end
    end
end
