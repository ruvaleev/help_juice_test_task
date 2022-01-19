# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
  end

  def search
    @articles =
      Article.where(
        'title LIKE :search_string OR body LIKE :search_string',
        search_string: "%#{params[:search_string]}%"
      )
  end
end
