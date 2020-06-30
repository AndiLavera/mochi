module Mochi::Helpers
  module Athena
    module FlashHandler
      def danger(str)
        flash[:danger] = str
      end

      def warning(str)
        flash[:warning] = str
      end

      def info(str)
        flash[:info] = str
      end

      def success(str)
        flash[:success] = str
      end
    end
  end
end
