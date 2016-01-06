class RecipesController < ApplicationController
  before_action :set_recipe, :only => [:edit, :update, :show, :like]
  before_action :require_user, :except => [:show, :index]
  before_action :require_same_user, :only => [:edit, :update]
  
  def index
    #before pagination: @recipes = Recipe.all.sort_by(&:number_of_thumbs_up).reverse #Equivalent of: Recipe.all.sort_by{|likes| likes.number_of_thumbs_up}.reverse
    @recipes = Recipe.paginate(:page => params[:page], :per_page => 4)
  end
  
  def show

  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    if @recipe.save
      flash[:success] = "Your recipe was subtitted succesfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated succesfully!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like
    @like = @recipe.likes.new(:like => like_params[:like], :chef => current_user)
    if @like.save
      flash[:success] = "You have amazing taste :)"
    else
      flash[:danger] = "Couldn't like it. You can only like/dislike once :("
    end
    redirect_to :back
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    def like_params
      params.permit(:like)
    end
    
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes"
        redirect_to root_path
      end
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
end