class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    products = Product.all.collect{ |product| collect_data(product) }
    render json: { code: 200, msg: "Success", data: products }
  end

  def show
    product = Product.find(params[:id]) rescue nil
    if product
      success_respond(product)
    else
      render json: { code: 404, msg: "Failed: data not found" }
    end
  end

  def create
    product = Product.new(product_params)

    if product.valid? && product.save
      success_respond(product)
    else
      render json: { code: 404, msg: "Failed: data not found" }
    end
  end

  def update
    product = Product.find(params[:id]) rescue nil
    data = product_params

    if product.present? && data.present? && product.update_attributes(data)
      success_respond(product)
    else
      render json: { code: 404, msg: "Failed: data not found" }
    end
  end

  def destroy
    product = Product.find(params[:id]) rescue nil

    if product.present? && product.destroy
      render json: { code: 200, msg: "Success", data: [] }
    else
      render json: { code: 404, msg: "Failed: data not found" }
    end
  end

  def success_respond(product)
    render json: { code: 200, msg: "Success", data: collect_data(product) }
  end

  def version
    render json: { code: 200, msg: "Success", data: { name: "Belanja API Demo", version: "1.0.0" } }
  end

  private
    def collect_data(record)
      { name: record.name, price: record.price, image: record.image }
    end

    def product_params
      data = {}
      data.merge!({ name: params[:name] }) if params[:name].present?
      data.merge!({ price: params[:price] }) if params[:price].present?
      data.merge!({ image: params[:image] }) if params[:image].present?

      return data
    end
end
