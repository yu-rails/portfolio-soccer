class TrainingsController < ApplicationController
  skip_before_action :login_required, {only: [:index]}
  before_action :ensure_correct_user, {only: [:destroy]}
  def new
    @training = Training.new
  end

  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to("/trainings")
      flash[:notice] = "トレーニングメニューを作成しました"
    else
      render("trainings/new")
    end
  end

  def show
    @training = Training.find(params[:id])
    @user = @training.user
    @clear = Clear.new
    @clears = Clear.all.where(training_id: @training.id).order(created_at: :desc)
    @clears = Kaminari.paginate_array(@clears).page(params[:page]).per(10)
    @clears_count = Clear.where(training_id: @training.id).count
    @clear_person = Clear.where(user_id: @user.id).where(training_id: @training.id)
  end

  def index
    @q = Training.where('end_on > ?', Date.today).ransack(params[:q])
    @trainings = @q.result(distinct: true).page(params[:page]).per(12)
    @clear = Clear.new
  end

  def destroy
    @training = current_user.trainings.find(params[:id])
    @training.destroy
    redirect_to("/trainings")
    flash[:notice] = "トレーニングメニューを削除しました！"
  end

  private

  def training_params
    params.require(:training).permit(:content, :tag, :end_on)
  end

  def ensure_correct_user
    @training = Training.find_by(id: params[:id])
    if @training.user_id != @current_user.id
      flash[:alert] = "#{@current_user.name}さんには他のページをオススメします"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
