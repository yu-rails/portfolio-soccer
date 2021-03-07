class UsersController < ApplicationController
  skip_before_action :login_required, {only: [:new, :confirm_new, :create]}
  before_action :forbid_login, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update, :favorites]}
  def new
    @user = User.new
  end

  def confirm_new
    @user = User.new(user_params)
    render :new unless @user.valid?
  end

  def create
    @user = User.new(user_params)
    
    if params[:back].present?
      render :new
      return
    end

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
    @favorite = Favorite.new
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user&.authenticate(user_params_edit[:password])
      if @user.update(user_params_edit)
        redirect_to("/users/#{@user.id}")
        flash[:notice] = "#{@user.name}さん！あなたの情報は無事変更できました！"       
      else
        render("users/edit")
      end
    else
      @user.errors.add(:password, 'が違います')
      render("users/edit")
    end

  end

  def trainings
    @user = User.find(params[:id])
    @favorite = Favorite.new
    @trainings = Training.all.where(user_id: @user.id)
    @trainings = Kaminari.paginate_array(@trainings).page(params[:page]).per(6)
  end
  def clears
    @user = User.find(params[:id])
    @favorite = Favorite.new
    @clears = Clear.all.where(user_id: @user.id).order(created_at: :desc)
    @clears = Kaminari.paginate_array(@clears).page(params[:page]).per(6)
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = Favorite.all.where(current_user_id: current_user.id).order(created_at: :desc)
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page]).per(10)
  end



  private

  def user_params
    params.require(:user).permit(:name, :nickname, :password, :password_confirmation, :back_number, :prefecture)
  end

  def user_params_edit
    params.require(:user).permit(:name, :password, :back_number, :prefecture, :image_name)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:alert] = "#{@current_user.name}さんには他のページをオススメします"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
