class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :user_is_not_seller, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
    @item.images.build  ## 追加
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to new_item_path, alert: @item.errors.full_messages
    end
  end

  def edit
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: "商品の編集が完了しました。"
    else
      redirect_to edit_item_path(@item), alert: @item.errors.full_messages
    end
  end

  def destroy
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
      :category_id,
      images_attributes: [:src, :id, :_destroy] 
      ).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_is_not_seller
    redirect_to root_path, alert: "あなたは出品者ではありません" unless @item.seller_id == current_user.id
  end

end
