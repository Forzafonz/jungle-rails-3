require 'rails_helper'

RSpec.describe User, type: :model do

  @user {
    User.new(
      first_name: 'Test_Name', 
      last_name: 'Test_Last_Name', 
      email: 'test@test.com', 
      password: 'applicationtest', 
      password_confirmation: 'applicationtest'
    )
  }

  describe 'Validations' do
    it 'should create a new user if all fields are present' do
      expect(@user.valid?).to be(true)
    end

    it 'should not create a new user if no first name provided' do
      @user.first_name = nil
      expect(@user.valid?).to be(false)
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'should not create a new user if no last name provided' do
      @user.last_name = nil
      expect(@user.valid?).to be(false)
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it 'should not create a new user if email is not present' do
      @user.email = nil
      expect(@user.valid?).to be(false)
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should not create a new user if password is not present' do
      @user.password = nil
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should not create a new user if password confirmation is not present' do
      @user.password_confirmation = nil
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'should not create a new user if password confirmation does not match the password' do
      @user. password_confirmation = 'anotherpassword'
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should not create a new user if a user with such email already exists' do
      @user_duplicate = User.new(
        first_name: 'Test_Name_2',
        last_name: 'Test_Last_Name_2',
        email: 'test@test.com',
        password: 'applicationtest',
        password_confirmation: 'applicationtest'
      )      
      expect(@user_duplicate.valid?).to be(false)
      expect(@user_duplicate.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not create a new user if password is less than 10 characters long' do
      @user.password = 'abc',
      @user.password_confirmation = 'abc'
      expect(@user.valid?).to be(false)
      expect(@user.errors.full_messages[0]).to include("Password is too short")
    end
  end
    
  describe '.authenticate_with_credentials' do
    
    it 'should log user in if the user is registered and password is correct' do
      expect(User.authenticate_with_credentials('test@test.com', 'applicationtest')).to be_truthy
    end

    it 'should not log the user in if the password is incorrect' do
      expect(User.authenticate_with_credentials('test@test.com', 'incorrectpassword')).to be(nil)
    end

    it 'should not log the user in if the email is not registered' do
      expect(User.authenticate_with_credentials('noemail@noemail.com', 'applicationtest')).to be(nil)
    end

    it 'should log user in if there are spaces before email' do
      expect(User.authenticate_with_credentials('  test@test.com', 'applicationtest')).to be_truthy
    end

    it 'should log user in if there are spaces after email' do
      expect(User.authenticate_with_credentials('test@test.com  ', 'applicationtest')).to be_truthy
    end

    it 'should log the user in if the email includes incorrectly cased characters' do
      expect(User.authenticate_with_credentials('TEST@test.com', 'applicationtest')).to be_truthy
    end

  end

end
