helpers do

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def show_door
    redirect '/' unless logged_in?
  end

end
