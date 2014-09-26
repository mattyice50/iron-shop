class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end


  def new
    if can? :manage, :items
      @item = current_user.items.new
    else
      redirect_to root_path
    end
  end

  def create
    if can? :manage, :items
      @item = current_user.items.new create_params
      if @item.save!
        redirect_to item_path(@item)
      else
        redirect_to :back
      end
    end

  end


  def edit
    if (current_user[:id] = params[:seller_id]) || (current_user.admin?)
      @item = Item.find(params[:id])
    else
      redirect_to :back, :alert => "You do not have permission to edit this item."
    end
  end

  def update
    if can? :manage, :items
      @item = Item.find(params[:id])
      if @item.update! create_params
        redirect_to @item
      else
        redirect_to @item, :alert => "Something went wrong"
      end
    else
      redirect_to root_path, :alert => "You do not have permission to modify edit this item."
    end
  end

  def watch
    item = Item.find_by_id params[:id]
    watcheditem = current_user.price_watches.new
    watcheditem.item_id = params[:id]
    watcheditem.save!
    redirect_to item, notice: "Item watched! You will receive emails when the price changes."

  end

  def unwatch
    item = Item.find_by_id params[:id]
    pricewatch = current_user.price_watches.find item.price_watches

    pricewatch.destroy

    redirect_to item, flash: { warning: "Item unwatched! You will not receive emails for this item anymore." }
  end

  def destroy

  end

  private

  def create_params
    params.require(:item).permit(:title, :price, :description, :avatar)
  end

end
