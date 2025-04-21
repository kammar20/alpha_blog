class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      flash[:notice] = "Welcome  #{@user.username} to the Alpha Blog."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
    @user= User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user = User.update(username: params[:username], email: params[:email], password: params[:password])
      flash[:notice] = "Your account information is successfully updated"
      redirect_to articles_path

    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end


end