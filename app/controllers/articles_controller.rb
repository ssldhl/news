class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles
  end

  private

  def serializer
    ArticleSerializer
  end
end
