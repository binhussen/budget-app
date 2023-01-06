class TransactionsController < ApplicationController
  def new
    @category = Category.find(params[:category_id])

    if @category.author == current_user
      @transaction = Transaction.new
    else
      flash[:alert] = 'You can only create transactions from your categories'
      redirect_to categories_path
    end
  end

  def create
    @category = Category.find(params[:category_id])
    if @category.author != current_user
      flash[:alert] = 'You can only create transactions from your categories'
      redirect_to categories_path
    end
    if transaction_params[:category_ids].length == 1
      flash[:alert] = 'Must select at least one category'
      redirect_to new_category_transaction_path(@category)
    else
      @category = Category.find(params[:category_id])
      @transaction = Transaction.new(transaction_params)
      @transaction.author = current_user

      if @transaction.save
        flash[:notice] = 'Transaction was created successfully'
        redirect_to @category
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, category_ids: [])
  end
end
