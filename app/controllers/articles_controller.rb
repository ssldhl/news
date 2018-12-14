class ArticlesController < ApplicationController
  def index
    articles = Article.recent
    render json: articles
  end

  private

  def serializer
    ArticleSerializer
  end
end
