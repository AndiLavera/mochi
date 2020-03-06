module Mochi::Helpers
  class ParamsHandler < Params
    def validate
      resource_params
    end

    def fetch(param)
      validate[param]
    end
  end
end
