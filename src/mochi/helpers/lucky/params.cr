module Mochi::Helpers
  class Params < BaseParams
    def validate
      resource_params.validate!
    end

    def find_param(param)
      resource_params.validate![param]
    end
  end
end