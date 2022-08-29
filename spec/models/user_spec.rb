require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it 'should create a new user' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: 'passw0rd'
      )

      expect(@user.valid?).to be true
      expect(@user.errors.full_messages).to be_empty
    end

    it 'should return the correct first and last name' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: 'passw0rd'
      )

      expect(@user.first_name).to include('fName')
      expect(@user.last_name).to include('lName')
    end

    it 'when first_name is nil, user is not valid' do
      @user = User.new(
        first_name: nil,
        last_name: 'lName',
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: 'passw0rd'
      )

      expect(@user.first_name).to be_nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'when last is nil, user is not valid' do
      @user = User.new(
        first_name: 'fName',
        last_name: nil,
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: 'passw0rd'
      )

      expect(@user.last_name).to be_nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'password and password_confirmation should match' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: 'passw0rd'
      )

      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'no password results in invalid user' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: nil,
        password_confirmation: 'passw0rd'
      )

      expect(@user.password).to be_nil
      expect(@user.valid?).to be false
    end

    it 'no password_confirmation results in invalid user' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: 'passw0rd',
        password_confirmation: nil
      )

      expect(@user.password_confirmation).to be_nil
      expect(@user.valid?).to be false
    end

    it 'password must be at least 8 characters long' do
      @user = User.new(
        first_name: 'fName',
        last_name: 'lName',
        email: 'test@test.com',
        password: 'bad',
        password_confirmation: 'bad'
      )

      expect(@user.valid?).to be false
    end

    it 'password is valid when 8 characters long' do
      @user = User.new(
        first_name: 'fname',
        last_name: 'lName',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )

      expect(@user).to be_valid
    end

    it 'email should be unique' do
      @user = User.new(
        first_name: 'fname',
        last_name: 'lName',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )

      @user.save

      @user2 = User.new(
        first_name: 'fname2',
        last_name: 'lName2',
        email: 'test@test.COM',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user2.save

      expect(@user.errors[:email]).to include('has already been taken')
    end
  end
end
