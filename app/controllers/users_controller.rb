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

end