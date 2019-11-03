module SessionsHelper
  
  def current_user
    if session[:user_id]
    current_user = User.find_by(id: session[:user_id])
    # nous allons vérifier s'il y a bien un cookie contenant l'id de notre utilisateur
    elsif cookies[:user_id]
      # nous allons trouver l'utilisateur en DB à partir du cookie qui stocke le user_id
      user = User.find_by(id: cookies[:user_id])
      if user
        # nous allons prendre le remember_token stocké en cookie, le hasher, puis le comparer avec notre remember_digest stocké en base
        remember_token = cookies[:remember_token]
        remember_digest = user.remember_digest
        user_authenticated = BCrypt::Password.new(remember_digest).is_password?(remember_token)
        # si tout est bon, il ne nous reste plus qu'à souhaiter bienvenue à l'utilisateur
        if user_authenticated
          log_in(user)
          current_user = user
        end
      end
    end
  end

   def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
  	(session[:user_id].nil?)? (return false) : (return true)
  end

  def is_owner?(id)
  	(current_user.id == id)? (return true) : (return false)
  end

  def remember(user)
    remember_token = SecureRandom.urlsafe_base64  
    user.remember(remember_token)
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def forget(user)
    user.update(remember_digest: nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out(user)
    session.delete(:user_id)
    forget(user)
  end

end
