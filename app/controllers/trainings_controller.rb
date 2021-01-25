class TrainingsController < ApplicationController
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
  end

  def index
    @trainings = Training.where('end_on > ?', Date.today)
  end

  def destroy
    @training = current_user.trainings.find(params[:id])
    @training.destroy
    redirect_to("/users/#{@lifting.user_id}")
    flash[:notice] = "トレーニングメニューを削除しました！"
  end

  private

  def training_params
    params.require(:training).permit(:content, :tag, :end_on)
  end
end
