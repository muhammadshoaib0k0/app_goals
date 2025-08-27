# frozen_string_literal: true
module Api
  module V1
    class BaseController < ApplicationController

      FIND_RESOURCE_ACTION = %i[show update destroy].freeze

      rescue_from Api::Errors::UnauthorizedError, with: :unauthorized_error
      rescue_from Api::Errors::ForbiddenError, with: :forbidden_error
      rescue_from Api::Errors::NotFoundError, with: :not_found_error
      rescue_from Api::Errors::WrongRequestFormatError, with: :wrong_request_format_error
      rescue_from Api::Errors::WrongFormatError, with: :wrong_format_error
      rescue_from Api::Errors::WrongStatusError, with: :wrong_status
      rescue_from Api::Errors::ValidationError, with: :validation_error
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
      rescue_from ActiveRecord::RecordInvalid, with: :custom_validation_error
      rescue_from StrataMaster::Errors::StrataMasterApiError, with: :strata_master_api_error
      rescue_from Elasticsearch::Transport::Transport::Errors::BadRequest, with: :custom_validation_error
      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        error = {}
        error[parameter_missing_exception.param] = [I18n.t('api.params_missing')]
        response = { errors: [error] }
        respond_to do |format|
          format.json { render json: response, status: :unprocessable_entity }
        end
      end
      
      def find_resource
        @resource = resource_class.find(params[:id])
      end
    
      def build_resource
        @resource = resource_class.new(permitted_params)
      end

      def cors_preflight_check
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        return unless request.method == :options
    
        render text: '', content_type: 'text/plain'
      en
    end
  end
end
