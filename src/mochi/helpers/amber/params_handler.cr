module Mochi::Helpers
  class ParamsHandler < Params
    def validate
      resource_params.validate!
    end

    def fetch(param)
      validate[param]
    end
  end
end
