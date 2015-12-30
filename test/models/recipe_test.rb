require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "Bob", email: "bob@test.com")
    @recipe = @chef.recipes.build(name: "Chicken parm", 
    summary: "This is the best recipe ever!", 
    description: "heat oil, add onions, add tomatos, ...")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length must not be more than 100 characters" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end

  test "name length must be more than 5 characters" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end

  test "summary must be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end

  test "summary lenth must not be more than 150 characters" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end

  test "summary length must be more than 9 characters" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end

  test "description must be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "descrition lenth must not be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

  test "descrition length must be more than 20 characters" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
end