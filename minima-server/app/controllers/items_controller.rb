class ItemsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_item, only: [:show, :update, :destroy]
  # protect_from_forgery with: :exception, only: :create

  def index
    items = Item.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded items', value: items }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the item', data: @item }
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: { status: 'SUCCESS', data: item }
    else
      render json: { status: 'ERROR', data: item.errors }
    end
  end

  def destroy
    @item.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the item', data: @item }
  end

  def update
    if @item.update(item_params)
      render json: { status: 'SUCCESS', message: 'Updated the item', data: @item }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @item.errors }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    # params.require(:item).permit(:name, :level)
    params
      .fetch(:item, {})
      .permit(
        :name, :level, :user_id, :category_id
      )
  end
end
