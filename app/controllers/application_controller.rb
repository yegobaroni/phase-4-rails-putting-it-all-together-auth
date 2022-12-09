class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize
  skip_before_action :authorize, only: :create

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def render_unprocessable_entity_response(valid)
    render json: { errors: valid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def authorize
    # using an instance method to be called on all need methods
    @current_user = User.find_by(id: session[:user_id])
    # render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

end