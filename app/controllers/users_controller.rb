class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :required_user, only: [:edit, :update]
before_action :require_same_user, only:[:edit, :update, :destroy]

  def index
    @users=User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      session[:user_id]= @user.id
      flash[:notice] = "Welcome  #{@user.username} to the Alpha Blog."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
  end
  
  def update
    if @user.update(username: params[:username], email: params[:email], password: params[:password])
      flash[:notice] = "Your account information is successfully updated"
      redirect_to @user

    else
      render "edit"
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to user_path(@user)
    end
end


end