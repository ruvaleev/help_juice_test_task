# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.by_title_or_body(params[:query])
  end
end
