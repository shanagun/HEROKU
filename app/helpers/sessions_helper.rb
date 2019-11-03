module SessionsHelper
  
  def current_user
    User.find_by(id: session[:user_id])
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
  
end
