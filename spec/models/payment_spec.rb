require 'rails_helper'

RSpec.describe Payment, type: :model do
  before(:example) do
    @user = User.create(name: 'Mohammed', email: 'binhussen@gmail.com', password: '123456')
    @category = Category.new(author: @user, name: 'Travel', icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')
  end

  context 'Validations' do
    it 'checks for name presence' do
      payment = Payment.new(author: @user, amount: 123, category_ids: [@category.id])
      expect(payment.valid?).to eq false
    end

    it 'checks for amount presence' do
      payment = Payment.new(author: @user, name: 'Nice One', category_ids: [@category.id])
      expect(payment.valid?).to eq false
    end

    it 'checks for name and amount presence' do
      payment = Payment.new(author: @user, name: 'Nice One', amount: 745, category_ids: [@category.id])
      expect(payment.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'belongs to an author' do
      payment = Payment.reflect_on_association('author')
      expect(payment.macro).to eq(:belongs_to)
    end

    it 'has many categories' do
      payment = Payment.reflect_on_association('categories')
      expect(payment.macro).to eq(:has_many)
    end
  end
end
