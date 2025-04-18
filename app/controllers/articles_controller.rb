class ArticlesController < ApplicationController
    
before_action :set_article, only: [:show, :edit, :update, :destroy]

    def show 
    end

    def index
        @articles=Article.all
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(title: params[:title], description: params[:description])

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
      
end
