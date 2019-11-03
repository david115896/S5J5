class SessionsController < ApplicationController

    skip_before_action :only_signed_in, only: [:new, :create]
    
    def new
    end

    def create
        # cherche s'il existe un utilisateur en base avec l’e-mail
        user_params = params.require(:user)
        @user = User.find_by(email: user_params[:email])
      
        # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
        if @user && @user.authenticate(user_params[:password])
          session[:user_id] = @user.id
          redirect_to gosssips_path, flash: {success: "Bon retour #{@user.first_name}" }
      
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
          #redirect_to new_session_path
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

   

end

