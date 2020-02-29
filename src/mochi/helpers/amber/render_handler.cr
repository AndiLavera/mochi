module Mochi::Helpers
  class RenderHandler < Render
    include Amber::Controller::Helpers::Render

    def user_new
      render("user/new.ecr")
    end

    def user_show
      render("user/show.ecr")
    end

    def user_edit
      render("user/edit.ecr")
    end

    def session_new
      render("session/new.ecr")
    end

    def session_show
      render("session/show.ecr")
    end

    def session_edit
      render("ussessioner/edit.ecr")
    end
  end
end