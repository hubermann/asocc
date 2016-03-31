require 'rails_helper'

RSpec.describe User, type: :model do
  before {
    @valid_attrs = { email: "algun@mail.com", password: "123456", password_confirmation: "123456" }
  }

  it "Deberia ser valido con los atributos por defecto" do
      @valid_attrs.delete(:email)
      user = User.new @valid_attrs
      user.valid?.should be_truthy
    end

end


