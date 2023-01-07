require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = User.create(name: 'Mohammed', email: 'binhussen@gmail.com', password: '123456')
  end

  context 'Validations' do
    it 'checks for name presence' do
      category = Category.new(author: @user, icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')
      expect(category.valid?).to eq false
    end

    it 'checks for icon presence' do
      category = Category.new(author: @user, name: 'Travel')
      expect(category.valid?).to eq false
    end

    it 'checks for name and icon presence' do
      category = Category.new(author: @user, name: 'Travel', icon: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png')
      expect(category.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'belongs to an author' do
      category = Category.reflect_on_association('author')
      expect(category.macro).to eq(:belongs_to)
    end

    it 'has many payments' do
      category = Category.reflect_on_association('payments')
      expect(category.macro).to eq(:has_many)
    end
  end
end
