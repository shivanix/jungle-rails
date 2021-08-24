#Used this command to generate user_spec file
#  rails generate rspec:model User

require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject do
    described_class.new(
      first_name:            "Testing",
      last_name:             "User",
      email:                 "test@test.com",
      password:              "shhsecret",
      password_confirmation: "shhsecret"
    ) 
  end

  describe 'Validations' do

    it "valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "invalid with missing first name" do
      subject.first_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("First name can't be blank")
    end

    it "invalid with missing last name" do
      subject.last_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("Last name can't be blank")
    end

    it "invalid with missing email" do
      subject.email = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("Email can't be blank")
    end

    it "invalid with missing password" do
      subject.password = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("Password can't be blank")
    end

    it "invalid with missing password confirmation" do
      subject.password_confirmation = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("Password confirmation can't be blank")
    end

    it "invalid with passwords that mismatch" do
      subject.password = "randompassword"
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end

    it "invalid with a short-length password" do
      subject.password = "p"
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.any? { |error|  error.include?("Password is too short") }).to be (true)
    end

    it "invalid with existing email" do
      user = User.new(
        first_name:            "Testing",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "shhsecret",
        password_confirmation: "shhsecret"
      )
      user.save
      subject.save
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end

    it "invalid with existing email case insensitive" do
      user = User.new(
        first_name:            "Testing",
        last_name:             "User",
        email:                 "TEST@TEST.COM",
        password:              "shhsecret",
        password_confirmation: "shhsecret"
      )
      user.save
      expect(user).to be_valid
      subject.save
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    
    it "returns nil with blank email and password" do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end

    it "returns nil with invalid email and nil password" do
      expect(User.authenticate_with_credentials("nothing@nothin.not", nil)).to eq(nil)
    end

    it "return nil with valid email and nil password" do
      User.new(
        first_name:            "Testing",
        last_name:             "User",
        email:                 "TEST@TEST.COM",
        password:              "shhsecret",
        password_confirmation: "shhsecret"
      ).save
      expect(User.authenticate_with_credentials("TEST@TEST.COM", nil)).to eq(nil)
    end

    it "return a user with valid email and password" do
      User.new(
        first_name:            "Testing",
        last_name:             "User",
        email:                 "example@example.com",
        password:              "shhsecret",
        password_confirmation: "shhsecret"
      ).save
      user = User.authenticate_with_credentials("example@example.com", "shhsecret")
      expect(user.email).to eq("example@example.com")
    end

    it "return a user with valid email and password case insensitive" do
      User.new(
        first_name:            "Testing",
        last_name:             "Theuser",
        email:                 "example@example.com",
        password:              "sshsecret",
        password_confirmation: "sshsecret"
      ).save
      user = User.authenticate_with_credentials("EXAMPLE@EXAMPLE.COM", "sshsecret")
      expect(user.email).to eq("example@example.com")
    end

    it "return a user with valid email and password case insensitive with leading spaces" do
      User.new(
        first_name:            "Testing",
        last_name:             "Theuser",
        email:                 "test@test.com",
        password:              "sshsecret",
        password_confirmation: "sshsecret"
      ).save
      user = User.authenticate_with_credentials("   TEST@TEST.COM", "sshsecret")
      expect(user.email).to eq("test@test.com")
    end

    it "return a user with valid email and password case insensitive with trailing spaces" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "sshsecret",
        password_confirmation: "sshsecret"
      ).save
      user = User.authenticate_with_credentials("TEST@TEST.COM   ", "sshsecret")
      expect(user.email).to eq("test@test.com")
    end

    it "return a user with valid email and password case insensitive with leading and trailing spaces" do
      User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              "sshsecret",
        password_confirmation: "sshsecret"
      ).save
      user = User.authenticate_with_credentials("   TEST@TEST.COM   ", "sshsecret")
      expect(user.email).to eq("test@test.com")
    end


  end
end
