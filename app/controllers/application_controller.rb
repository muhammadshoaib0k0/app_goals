# frozen_string_literal: true

class ApplicationController < ActionController::Base

    def json_request?
        request.format.json?
    end

    def api_namespace_request?
        request.original_fullpath.start_with?('/api/')
    end

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
  
end
