class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def new
    @item = Item.new
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      render layout: 'no_menu', template: 'items/new' # レイアウトファイル指定
    end
  end

  def edit
    @item = Item.find(params[:id])  ## 追加
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path, notice: "商品の編集が完了しました。"
    else
      render layout: 'no_menu', action: :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to root_path, notice: "商品の削除が完了しました。"
    else
      redirect_to edit_item_path(@item), alert: "商品が削除できませんでした。"
    end
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
