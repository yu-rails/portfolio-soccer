class SessionsController < ApplicationController
  skip_before_action :login_required
  before_action :forbid_login, {only: [:new, :create]}
  def new
  end
  def create
    user = User.find_by(nickname: session_params[:nickname])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to("/users/#{session[:user_id]}")
      flash[:notice] = "ログイン完了です#{user.name}さん！"
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to("/")
    flash[:notice] = "ログアウト完了です！"
  end

  private

  def session_params
    params.require(:session).permit(:nickname, :password)
  end
end
