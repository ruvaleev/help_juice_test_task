# frozen_string_literal: true

class ArticleQueriesController < ApplicationController
  def create
    ArticleQuery.upsert_all(article_query_params, unique_by: [:created_at, :user_id])

    head :created
  end

  def destroy
    ArticleQuery.where(user_id: session[:session_id]).destroy_all
    head :ok
  end

  private

  def article_query_params
    params[:article_query].map! do |query_param|
      query_param.merge(user_id: session[:session_id]).permit(:body, :created_at, :user_id)
    end
  end
end
