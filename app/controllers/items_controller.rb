class ItemsController < ApplicationController

  def new
    @item = Item.new
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path, notice: "出品に成功しました"
    else
      render layout: 'no_menu', template: 'items/new' # レイアウトファイル指定
    end
  end

  def edit
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def purchase_confirmation
    render layout: 'no_menu' # レイアウトファイル指定
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :detail,
      :condition,
      :delivery_fee_payer,
      :delivery_method,
      :delivery_days,
      :prefecture_id,
      :category_id
      ).merge(seller_id: current_user.id)
  end

end
