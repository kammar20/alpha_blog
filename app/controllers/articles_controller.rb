class ArticlesController < ApplicationController
    
before_action :set_article, only: [:show, :edit, :update, :destroy]
before_action :required_user, except: [:show, :index]
before_action :require_same_user, only: [:edit, :update, :destroy]

    def show 
    end

    def index
        @articles=Article.paginate(page: params[:page], per_page: 3)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(title: params[:title], description: params[:description])
            @article.user = current_user
            if @article.save
                flash[:notice] = "Article was created successfully"
                redirect_to @article
            else
                render "new"
            end
    end


    def edit
        
    end

    def update
        if @article.update(title: params[:title], description: params[:description])
            flash[:notice]= "Article is updated successfully"
            redirect_to @article
        else
            render "edit"
        end 
    end


    def destroy
        @article.destroy
        flash[:notice] = "Article was deleted successfully."
        redirect_to articles_path
    end


    private

    def set_article
        @article = Article.find(params[:id])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only delete or edit your own article"
            redirect_to article_path(@article)
        end
    end
      
end
