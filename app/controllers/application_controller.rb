# frozen_string_literal: true

class ApplicationController < ActionController::Base

    def json_request?
        request.format.json?
    end

    def api_namespace_request?
        request.original_fullpath.start_with?('/api/')
    end
end
