module Mochi::Helpers
  module Athena
    module RenderHandler
      def user_new
        render("user/new.ecr")
      end

      def user_show
        render("user/show.ecr")
      end

      def user_edit
        render("user/edit.ecr")
      end
    end
  end
end
