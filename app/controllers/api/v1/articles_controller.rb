class Api::V1::ArticlesController < ApplicationController
  
  def index
    articles=Article.all
    render json: articles, status: 200
  end

  def show
    article=Article.find_by(id: params[:id])
    if article
      render json: article, status:200
    else
      render json:{
        error:"Article not found"
      }
    end
  end

  def create
    article=Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article,status:200
    else
      render json: {
        errpr: "Error in creating..."
      }
    end
  end

  def update
    article=Article.find_by(id: params[:id])
    if article
      article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: article, message:"Article updated succesfully"
    else
      render json: {
        error: "Article not found..."
    }
    end

  end

  def destroy
    article=Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article have been deleted succesfully"
    
    else
      render json: "Article does not exhist"
    end
  end

  private
  def arti_params
    params.require(:article).permit([
        :title,
        :body,
        :author
    ])
  end
end
