class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      current_user_items = @current_user.items
      render json: { status: 'SUCCESS', message: 'Loaded users', value: {user: @current_user, items: current_user_items} }          
    else
      users = User.all
      render json: { status: 'SUCCESS', message: 'Loaded users', value: users }
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      # params.require(:user).permit(:email, :uid, :name)
      params.fetch(:user, {}).permit(
        :username, :email, :uid
      )
    end
end