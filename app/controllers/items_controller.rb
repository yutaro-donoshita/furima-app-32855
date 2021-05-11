class ItemsController < ApplicationController
  def index
  end
  
  def new
     unless user_signed_in?
       redirect_to new_user_session_path
     end
     @item=Item.new
   end

   def create
     @item=Item.create(item_params)
     if @item.save
       redirect_to root_path
     else
       render:new
     end
   end

   private
   def item_params
     params.require(:item).permit(:item_name,:item_text,:category_id,:status_id,:delivery_fee_id,:prefecture_id,:shipment_date_id,:price,:item_image,:tittle,).merge(user_id:current_user.id)
   end
 end