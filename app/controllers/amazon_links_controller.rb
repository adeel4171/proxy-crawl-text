class AmazonLinksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @all_products = AmazonLink.all.pluck(:product_details)

    respond_to do |format|
      format.html
      format.json {render json: @all_products}
    end
  end

  def show
    @product = AmazonLink.find(params[:id])
    respond_to do |format|
      format.html {render plain: "Login to admin dashboard to view the data"}
      format.json {render json: @product}
    end
  end

  def destory
    @product = AmazonLink.find(params[:id])
    @product.destory
    respond_to do |format|
      format.html {render plain: "Login to admin dashboard to view the data"}
      format.json {render json: @product}
    end
  end

  def create
    @product = AmazonLink.create!(product_params)
    respond_to do |format|
      format.html {render plain: "Login to admin dashboard to view the data"}
      format.json {render json: @product}
    end
  end

  def update
    @product = AmazonLink.find(params[:id])
    @product.update!(product_params)
    respond_to do |format|
      format.html {render plain: "Login to admin dashboard to view the data"}
      format.json {render json: @product}
    end
  end

  def fetch_products
    AmazonLink.fetch_products
    render json: "Crawler will update the products shortly!"
  end

  def product_params
    params.permit(:url, :product_details)
  end
end
