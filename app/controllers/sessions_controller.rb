class SessionsController < ApplicationController

  def new
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      remember(user)
      redirect_to root_path
    else
      flash[:notice] = "Email ou Mot de passe invalide"
      render 'new'
    end
  end

  def destroy
    log_out(current_user)
    flash[:notice] = "Vous êtes maintenant déconnecté"
    redirect_to root_path
  end

end