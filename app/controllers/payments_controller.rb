class PaymentsController < ApplicationController
  def new
    @category = Category.find(params[:category_id])

    if @category.author == current_user
      @payment = Payment.new
    else
      flash[:alert] = 'You can only create payments from your categories'
      redirect_to categories_path
    end
  end

  def create
    @category = Category.find(params[:category_id])
    if @category.author != current_user
      flash[:alert] = 'You can only create payments from your categories'
      redirect_to categories_path
    end
    if payment_params[:category_ids].length == 1
      flash[:alert] = 'Must select at least one category'
      redirect_to new_category_payment_path(@category)
    else
      @category = Category.find(params[:category_id])
      @payment = Payment.new(payment_params)
      @payment.author = current_user

      if @payment.save
        flash[:notice] = 'Payment was created successfully'
        redirect_to @category
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end
