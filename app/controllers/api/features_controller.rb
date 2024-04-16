class Api::FeaturesController < ApplicationController
  before_action :set_feature, only: [:show]

  # GET /api/features
  def index
    @features = Feature.all

    # Filtrar por mag_type
    if params[:mag_type].present?
      @features = @features.where(mag_type: params[:mag_type])
      puts("inside para[:mag_type] condition")
      pp @features
    end 

    # Obtener tipos de magnitud únicos
    mag_types = Feature.distinct.pluck(:mag_type)

    # Pagination
    per_page = params[:per_page]&.to_i || 10
    per_page = 1000 if per_page > 1000 
    @features = @features.paginate(page: params[:page], per_page: per_page)
    
    total_pages = @features.total_pages
    response.headers['X-Total-Pages'] = total_pages.to_s
    
    render json: {features: @features, total_pages: total_pages, current_page: params[:page], mag_types: mag_types }, each_serializer: FeatureSerializer, status: :ok
  end

  # GET /api/features/:id
  def show
    # Obtener el feature específico
    feature_data = {
      feature: @feature,
      comments: @feature.comments.order(created_at: :desc)
    }
    render json: feature_data, status: :ok
  end

  private 

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def comment_params
    params.permit(:body)
  end 

end
