class ClearsController < ApplicationController

  def create
    @clear = Clear.new(user_id: current_user.id, training_id: params[:training_id])
    @clear.save
    #redirect_to("/trainings/#{params[:training_id]}")
    redirect_back(fallback_location: root_path)
  end
  def destroy
    @clear = Clear.find_by(user_id: current_user.id, training_id: params[:training_id])
    @clear.destroy
    #redirect_to("/trainings/#{params[:training_id]}")
    redirect_back(fallback_location: root_path)
  end


end