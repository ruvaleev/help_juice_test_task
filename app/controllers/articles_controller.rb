# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.where(
      'title ILIKE :query OR body ILIKE :query',
      query: "%#{params[:query]}%"
    )
  end
end
