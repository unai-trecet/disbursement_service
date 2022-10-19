class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :bad_request
  rescue_from TypeError, with: :bad_request


  private
  
  def bad_request
    render json: {
      error: :bad_request,
      status: 400
    }, status: 400
  end
end
