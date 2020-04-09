module Mochi::Helpers
  module RenderHandler

    def render_user_new
      render("user/new.ecr")
    end

    def render_user_show
      render("user/show.ecr")
    end

    def render_user_create
      render("user/create.ecr")
    end

    def render_user_edit
      render("user/edit.ecr")
    end

    def render_session_new
      render("session/new.ecr")
    end

    def render_session_show
      render("session/show.ecr")
    end

    def render_session_edit
      render("session/edit.ecr")
    end

    def render_recovery_new
      render("recovery/new.ecr")
    end

    def render_invite_new
      render("invitable/new.ecr")
    end

    def render_invite_edit
      render("invitable/edit.ecr")
    end
  end
end
