class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    render json: Spice.all, status: :ok
  end

  def show
    spice = spice_finder
    render json: spice, status: :ok
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = spice_finder
    spice.update(spice_params)
    render json: spice, status: :accepted
  end

  def destroy
    spice = spice_finder
    spice.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { error: "Spice not found" }, status: :not_found
  end

  def spice_finder
    Spice.find(params[:id])
  end

  def spice_params
    params.permit(:id, :title, :image, :description, :notes, :rating)
  end
end
