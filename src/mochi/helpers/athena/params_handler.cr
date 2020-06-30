module Mochi::Helpers
  module Athena
    module ParamsHandler
      def validate
        resource_params.validate!
      end

      def fetch(param)
        validate[param]
      end
    end
  end
end
