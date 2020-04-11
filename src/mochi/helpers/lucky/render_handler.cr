module Mochi::Helpers
  module Lucky
    module RenderHandler
      def user_new
        html User::NewPage
      end

      def user_show
        html User::ShowPage
      end

      def user_edit
        html User::EditPage
      end
    end
  end
end
