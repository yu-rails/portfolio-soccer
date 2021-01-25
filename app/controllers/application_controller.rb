class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :current_user
  before_action :login_required

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end



  def login_required
    redirect_to login_url,alert: "まずログインをする必要があります" unless current_user
  end

  def forbid_login
    if current_user
      flash[:alert] = "すでにログインしています"
      redirect_to("/users/#{@current_user.id}")
    end
  end

end
