class ItemsController < ApplicationController

  before_action :authenticate_user! ,only: [:new,:create] 

  def index
    @items=Item.includes(:user).order('created_at DESC')
  end
  
  def new
     @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
       render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    redirect_to root_path if (current_user.id != @item.user_id) || !@item.order.nil?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      @item
      render :edit
    end
  end

  private
   def item_params
     params.require(:item).permit(:item_name,:item_text,:category_id,:status_id,:delivery_fee_id,:prefecture_id,:shipment_date_id,:price,:item_image).merge(user_id:current_user.id)
   end
end