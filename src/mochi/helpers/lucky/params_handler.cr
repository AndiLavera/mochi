module Mochi::Helpers
  module Lucky
    module ParamsHandler
      def validate
        resource_params
      end

      def fetch(param)
        validate[param]
      end
    end
  end
end
