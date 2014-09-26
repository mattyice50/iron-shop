class RegistrationsController < Devise::RegistrationsController

  def create
    super
    current_user.carts.create!
  end

  def new
    super
  end

  def update
    super
    
  end


end
