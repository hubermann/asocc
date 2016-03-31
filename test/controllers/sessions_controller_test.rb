require 'test_helper'

class SessionsControllerTest < ActionController::TestCase


	test "validar que tenga email" do
		user = User.new(email: nil)
		assert_not user.valid? 
	end

	test "validar que tenga password" do
		user = User.new(password: nil)
		assert_not user.valid? 
	end

	test "validar que tenga persistence_token" do
		user = User.new(persistence_token: nil)
		assert_not user.valid? 
	end





end
