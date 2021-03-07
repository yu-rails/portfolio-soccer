class LiftingsController < ApplicationController
  before_action :set_lifting, only: [:destroy]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def show
    @lifting = Lifting.find_by(id: params[:id])
    @user = @lifting.user
  end

  def new
    @lifting = Lifting.new
  end

  def create
    @lifting = current_user.liftings.new(lifting_params)
    
    if @lifting.save
      redirect_to("/users/#{@current_user.id}")
      flash[:notice] = "今日のリフティングの最高記録は#{@lifting.record}回ですね！記録しました！"
    else
      render("liftings/new")
    end
  end

  def edit
    @lifting = Lifting.find(params[:id])
  end

  def update
    @lifting = Lifting.find(params[:id])
    if @lifting.update(lifting_params)
      redirect_to("/liftings/#{@lifting.id}")
      flash[:notice] = "今日のリフティングの最高記録を#{@lifting.record}回に更新しました！"
    else
      render("/liftings/edit")
    end
  end

  def destroy
    @lifting.destroy
    redirect_to("/users/#{@lifting.user_id}")
    flash[:notice] = "リフティングの最高記録を削除しました！"
  end

  private

  def lifting_params
    params.require(:lifting).permit(:record, :remark)
  end
  def set_lifting
    @lifting = current_user.liftings.find(params[:id])
  end
  def ensure_correct_user
    @lifting = Lifting.find_by(id: params[:id])
    if @lifting.user_id != @current_user.id
      flash[:alert] = "#{@current_user.name}さんには他のページをオススメします"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
