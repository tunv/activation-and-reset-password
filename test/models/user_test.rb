require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user =User.new(name:"Ex1",email:"Ex1@gmail.com",password: "foobar", password_confirmation: "foobar")
  end
  test "should be valid" do assert @user.valid?
  end
  test "name should be present" do
  	@user.name=" "
  	assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
	@user.name="a"*51
	assert_not @user.valid?
  end

  test "email should not be too long" do
	@user.email="a"*256
	assert_not @user.valid?
  end
  
 test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end


    test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
    end


end
