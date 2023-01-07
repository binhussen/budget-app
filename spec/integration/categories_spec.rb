require 'rails_helper'

RSpec.describe 'Categories', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Mohammed Hussen', email: 'binhussens@mail.com', password: '123456')
      sign_in @user

      @category = Category.create(author: @user, name: 'Apple', icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')
      visit categories_path
    end

    it 'renders name of category' do
      expect(page).to have_content(@category.name)
    end

    it 'renders icon of category' do
      find("img[src='#{@category.icon}']")
    end

    it 'renders total payments of the category' do
      expect(page).to have_content(@category.payments.sum(:amount))
    end

    it 'redirects to category show page' do
      click_link @category.name
      expect(page).to have_current_path(category_path(@category))
    end

    it 'redirects to create new category page' do
      click_link 'Add new category'
      expect(page).to have_current_path(new_category_path)
    end
  end
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Mohammed', email: 'binhhusen@mail.com', password: '123456')
      sign_in @user

      @category = Category.create(author: @user, name: 'Apple', icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')

      @payment = Payment.create(author: @user, name: 'Movie Ticket', amount: 26, category_ids: [@category.id])
      visit category_path(@category)
    end

    it 'renders name of category' do
      expect(page).to have_content(@category.name)
    end

    it 'renders total payments of that category' do
      expect(page).to have_content(@category.payments.sum(:amount))
    end

    it 'renders payment name' do
      expect(page).to have_content(@payment.name)
    end

    it 'renders payment amount' do
      expect(page).to have_content(@payment.amount)
    end

    it 'redirects to create new payment page' do
      click_link 'Add new payment'
      expect(page).to have_current_path(new_category_payment_path(@category))
    end

    it 'redirects to categories page' do
      click_link 'Back'
      expect(page).to have_current_path(categories_path)
    end
  end
end
