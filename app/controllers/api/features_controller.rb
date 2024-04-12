class Api::FeaturesController < ApplicationController
  before_action :set_feature, only: [:create_comment]

  # GET /api/features
  def index
    @features = Feature.all

    # Filtrar por mag_type
    if params[:filters].present? && params[:filters][:mag_type].present?
      @features = @features.where(mag_type: params[:filters][:mag_type])
    end 

    # Pagination
    per_page = params[:per_page]&.to_i || 10
    per_page = 1000 if per_page > 1000 
    @features = Feature.paginate(page: params[:page], per_page: params[:per_page])
    
    render json: @features, each_serializer: FeatureSerializer, status: :ok
  end

  # POST /api/features/:id/comments
  def create_comment
    comment = @feature.comments.build(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private 

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end 

end
