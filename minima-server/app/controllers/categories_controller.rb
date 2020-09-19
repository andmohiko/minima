class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      render json: {
        status: 'SUCCESS',
        message: 'Loaded categories',
        value: @current_user.categories
      }
    else
      categories = Category.order(created_at: :desc)
      render json: { status: 'SUCCESS', message: 'Loaded categories', value: categories }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the item', data: @category }
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: { status: 'SUCCESS', message: 'Created category', data: category }
    else
      render json: { status: 'ERROR', message: 'Not created', data: category.errors }
    end
  end

  def destroy
    @category.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the category', data: @category }
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    # params.require(:category).permit(:name, :level)
    params
      .fetch(:category, {})
      .permit(
        :name, :user_id
      )
  end
end
