class DiscountsController < ApplicationController 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])

    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash[:alert] = "Fill in all fields."
      render :edit
    end
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.build(discount_params)

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/discounts"
    else
      flash[:alert] = "Fill in all fields."
      render :new
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  
  def discount_params
    params.permit(:percent, :quantity_threshold)
  end
end
