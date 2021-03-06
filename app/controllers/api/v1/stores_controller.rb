class Api::V1::StoresController < ApplicationController

  # GET v1/stores
  def index
    @stores = Store.all

    if @stores.present?
      render json: @stores, status: :ok
    else
      render json: { error: 'No stores found' }, status: :not_found
    end
  end

  # GET v1/inventory
  def inventory
    StoreService.new.fetch_data
    redirect_to api_v1_stores_url
  end

  # GET v1/alerts
  def alerts
    @stores = Store.where(status: [:empty, :warning, :attention, :full])

    if @stores.present?
      render json: { message: 'Stores that need attention with their inventory!', stores: @stores }
    else
      render json: { error: 'No alerts were created for the stores saved!' }, status: :not_found
    end
  end
end
