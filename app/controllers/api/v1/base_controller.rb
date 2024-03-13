# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController

      FIND_RESOURCE_ACTION = %i[show update destroy].freeze
    end
  end
end
