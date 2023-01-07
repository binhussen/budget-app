require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it 'checks if name is empty' do
      user = User.new(email: 'test@gmail.com', password: '123456')
      expect(user.valid?).to eq false
    end

    it 'checks if name is present' do
      user = User.new(name: 'Amejid', email: 'test@gmail.com', password: '123456')
      expect(user.valid?).to eq true
    end
  end

  context 'Associations' do
    it 'has many categories' do
      user = User.reflect_on_association('categories')
      expect(user.macro).to eq(:has_many)
    end

    it 'has many payments' do
      user = User.reflect_on_association('payments')
      expect(user.macro).to eq(:has_many)
    end
  end
end
