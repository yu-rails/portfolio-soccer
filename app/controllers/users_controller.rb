class UsersController < ApplicationController
  skip_before_action :login_required, {only: [:new, :create]}
  before_action :forbid_login, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.jpg"

    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
      flash[:notice] = "#{@user.name}さん！ようこそ練習記録管理サイトへ！"
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @max = @user.liftings.maximum(:record)
    @liftings = @user.liftings.all.order(created_at: :desc)
    @liftings = Kaminari.paginate_array(@liftings).page(params[:page]).per(10)
  end
  
  def update
    @user = User.find(params[:id])
    
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image_name]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.update(user_params_edit)
      redirect_to("/users/#{@user.id}")
      flash[:notice] = "#{@user.name}さん！あなたの情報は無事変更できました！"
    else
      render("users/edit")
    end
  end

  private

  def user_params
    params.permit(:name, :nickname, :password, :password_confirmation, :back_number)
  end

  def user_params_edit
    params.permit(:name, :password, :password_confirmation, :back_number)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:alert] = "#{@current_user.name}さんには他のページをオススメします"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
