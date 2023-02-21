class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by({ "email" => params["email"] })
        if @user
            if BCrypt::Password.new(@user["password"]) == params["password"]
                cookies["monster"] = "me like cookies"
                session["user_id"] = @user["id"]
                redirect_to "/companies"
            else
                redirect_to "/sessions/new"
            end
        else
            redirect_to "/sessions/new"
        end
    end

    def destroy
        session["user_id"] = nil
        redirect_to "/sessions/new"
    end
end
