# app/controllers/api/comments_controller.rb
class Api::CommentsController < ApplicationController
  before_action :set_feature

  # GET /api/features/:id/comments
  def index
    comments = @feature.comments.order(created_at: :desc)
    render json: comments, status: :ok
  end

  # POST /api/features/:id/comments
  def create
    comment = @feature.comments.build(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end

  def comment_params
    params.permit(:body)
  end
end
