class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: %i[index show]

  def index
    articles = Article.recent.page(current_page).per(per_page)
    options = PaginationMetaGenerator
              .new(request: request,
                   total_pages: articles.total_pages)
              .generate
    render json: serializer.new(articles, options)
  end

  private

  def serializer
    ArticleSerializer
  end

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || 20).to_i
  end
end
