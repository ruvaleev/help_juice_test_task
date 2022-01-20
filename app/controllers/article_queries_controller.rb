# frozen_string_literal: true

class ArticleQueriesController < ApplicationController
  def create
    ArticleQuery.create(article_query_params)

    head :created
  end

  private

  def article_query_params
    params[:article_query].map! do |query_param|
      query_param.merge(user_id: session[:session_id]).permit(:article_id, :body, :user_id)
    end
  end
end
