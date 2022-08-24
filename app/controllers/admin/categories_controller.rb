class Admin::CategoriesController < ApplicationController
  include HttpAuthConcern

  def index
    # @categories = Cate.order(id: :desc).all
  end

  def new
    # @product = Product.new
  end

  def create
    # @product = Product.new(product_params)

    # if @product.save
    #   redirect_to %i[admin products], notice: 'Product created!'
    # else
    #   render :new
    # end
  end
end
