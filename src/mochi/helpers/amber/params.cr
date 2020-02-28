module Mochi::Helpers
  class Params < BaseParams
    def validate
      resource_params.validate!
    end

    def find_param(param)
      validate[param]
    end
  end
end