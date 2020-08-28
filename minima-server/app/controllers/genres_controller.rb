class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :update, :destroy]

  def index
    genres = Genre.all
    render json: { status: 'SUCCESS', message: 'Loaded genres', value: genres }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the genre', data: @genre }
  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      render json: { status: 'SUCCESS', message: 'Created genre', data: genre }
    else
      render json: { status: 'ERROR', message: 'Not created', data: genre.errors }
    end
  end

  def destroy
    @genre.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the genre', data: @genre }
  end

  private
    def set_genre
      @genre = Genre.find(params[:id])
    end

    def genre_params
      params.fetch(:genre, {})
      .permit(
        :name, :user_id
      )
    end
end
