# frozen_string_literal: true

class ApplicationController < ActionController::Base

  def json_request?
      request.format.json?
  end

  def api_namespace_request?
      request.original_fullpath.start_with?('/api/')
  end

  # GET api/v1/:resource/:id as JSON
  def show
    render json: @resource, root: false, include: '**'
  end

  # POST api/v1/:resource as JSON
  def create
    if @resource.save
      render json: @resource, status: :created, root: false
    else
      render json: auth_api_response(@resource.errors.messages, 'error'), status: :unprocessable_entity
    end
  end
    
  # PUT api/v1/:resource/:id as JSON
  def update
    if @resource.save
      render json: @resource, root: false
    else
      render json: auth_api_response(@resource.errors.messages, 'error'), status: :unprocessable_entity
    end
  end
    
  # DELETE api/v1/:resource/:id as JSON
  def destroy
    if @resource.destroy
      render json: @resource, root: false
    else
      render json: auth_api_response(@resource.errors.messages, 'error'), status: :unprocessable_entity
    end
  end
end
