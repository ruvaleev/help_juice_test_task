# frozen_string_literal: true

class ArticleQueriesController < ApplicationController
  def index
    @article_queries = ArticleQuery.statistics_by_session_id(session[:session_id])

    respond_to do |format|
      format.json { render json: @article_queries }
    end
  end

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
