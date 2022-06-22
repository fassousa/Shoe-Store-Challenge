class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: %i[show update destroy]

  # GET /stores
  def index
    @stores = Store.all

    if @stores.present?
      render json: @stores
    else
      render json: { error: 'No stores found' }, status: :not_found
    end
  end

  # GET /stores/1
  def show
    render json: @store
  end

  # POST /stores
  def create
    @store = Store.new(store_params)

    if @store.save
      render json: @store, status: :created, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      render json: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stores/1
  def destroy
    @store.destroy
  end

  def inventory
    # call store service to fetch data
    StoreService.new.fetch_data
    redirect_to api_v1_stores_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def store_params
    params.require(:store).permit(:name, :model, :inventory)
  end
end
