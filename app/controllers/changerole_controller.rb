class ChangeroleController < ApplicationController
  def update
    if params[:role] == "seller"
      current_user.update_attributes(seller: true, shopper: false)
    elsif params[:role] == "shopper"
      current_user.update_attributes(shopper: true, seller: false)
    end
    redirect_to root_path
  end
end
