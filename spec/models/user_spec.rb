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

    it 'email must be unique' do
      user = User.new
      user.first_name = 'first_name'
      user.last_name = 'last_name'
      user.email = 'test@test.com'
      user.password = 'password'
      user.password_confirmation = 'password'

      user.save

      user2 = User.new
      user2.first_name = 'first_name'
      user2.last_name = 'last_name'
      user2.email = 'test@test.com'
      user2.password = 'password'
      user2.password_confirmation = 'password'
      user2.save

      # raise user2.errors[:email].inspect

      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'email must be unique, regardless of case' do
      user = User.new
      user.first_name = 'first_name'
      user.last_name = 'last_name'
      user.email = 'test@test.com'
      user.password = 'password'
      user.password_confirmation = 'password'

      user.save

      user2 = User.new
      user2.first_name = 'first_name'
      user2.last_name = 'last_name'
      user2.email = 'TEST@TEST.com'
      user2.password = 'password'
      user2.password_confirmation = 'password'
      user2.save

      # raise user2.errors[:email].inspect

      expect(user2.errors[:email]).to include('has already been taken')
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass when valid credentials are passed into User.new()' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', '12345678')
      expect(user).not_to be(nil)
    end

    it 'should pass when email has spaces before and after' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      # spaces in email here
      user = User.authenticate_with_credentials('      test@test.com      ', '12345678')
      expect(user).not_to be(nil)
    end

    it 'should pass when email has UPPER CASE letters' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      # spaces in email here
      user = User.authenticate_with_credentials('TEST@TEST.coM', '12345678')
      expect(user).not_to be(nil)
    end
  end
end
