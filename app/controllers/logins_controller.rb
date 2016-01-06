class LoginsController < ApplicationController
  def new
    
  end
  
  def create
    chef = Chef.find_by_email(params[:email])
    if chef and chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "Welcome back #{chef.chefname}"
      redirect_to recipes_path
    else
      flash[:danger] = "Login failed"
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "Logged out. See you later!"
    redirect_to root_path
  end
end