class FavoritesController < ApplicationController
  
  def create
    @favorite = Favorite.new(current_user_id: current_user.id, user_id: params[:user_id])
    @favorite.save
    #redirect_to("/users/#{params[:user_id]}")
    redirect_back(fallback_location: root_path)
  end
  def destroy
    @favorite = Favorite.find_by(current_user_id: current_user.id, user_id: params[:user_id])
    @favorite.destroy
    #redirect_to("/users/#{params[:user_id]}")
    redirect_back(fallback_location: root_path)
  end
end
