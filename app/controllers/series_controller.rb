class SeriesController < ApplicationController
  before_action :set_serie, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def index
    @series = Serie.all
    render json: @series
  end

  def show
    render json: @serie
  end

  def create
    @serie = Serie.new(serie_params)
    if @serie.save
      render json: @serie, status: :created, location: @serie
    else
      render json: @serie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @serie.update(serie_params)
      render json: @serie, status: :ok, location: @serie
    else
      render json: @serie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @serie.destroy
    render json: Serie.all
  end

  private
    def set_serie
      @serie = Serie.find(params[:id])
    end

    def serie_params
      params.require(:serie).permit(:nombre, :temporadas, :descripcion, :imagen, :en_transmision)
    end
end
