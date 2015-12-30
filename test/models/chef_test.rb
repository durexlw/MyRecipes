require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end
  
  test "chef must be valid" do
    assert @chef.valid?
  end
  
  test "chefname must be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname must not be more than 40 characters" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname must be at least 3 characters" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid adresses" do
    valid_adresses = %w[aaa@test.be john@exmaple.com test@hello.mine.org]
    valid_adresses.each do |va|
      @chef.email = va
      assert @chef.valid?, "#{va.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid adresses" do
    invalid_adresses = %w["john@exmaple,com" "aaa@test." "test@hello.mine.or+g"]
    invalid_adresses.each do |iva|
      @chef.email = iva
      assert_not @chef.valid?, "#{iva.inspect} should be invalid"
    end
  end
end