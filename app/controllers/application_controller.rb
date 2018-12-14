class ApplicationController < ActionController::API
  def render(options = {})
    pagination = PaginationMetaGenerator
                 .new(request: request,
                      total_pages: options[:json].total_pages)
                 .generate
    options[:json] = serializer.new(options[:json], pagination)
    super(options)
  end
end
