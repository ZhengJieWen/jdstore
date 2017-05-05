class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = '你的购物车内已有此物品'
       end
    redirect_to :back
end

def add_quantity
        @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
        if @cart_item.quantity < @cart_item.product.quantity
             @cart_item.quantity += 1
             @cart_item.save
             redirect_to carts_path
        elsif @cart_item.quantity == @cart_item.product.quantity
             redirect_to carts_path, alert: "库存不足！"
        end
end

def remove_quantity
    @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
    if @cart_item.quantity > 0
         @cart_item.quantity -= 1
         @cart_item.save
         redirect_to carts_path
    elsif @cart_item.quantity == 0
         redirect_to carts_path, alert: "商品不能少于零！"
    end
end

end
