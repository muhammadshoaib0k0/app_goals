# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController

      FIND_RESOURCE_ACTION = %i[show update destroy].freeze
      def find_resource
        @resource = resource_class.find(params[:id])
      end
    
      def build_resource
        @resource = resource_class.new(permitted_params)
      end
    end
  end
end
