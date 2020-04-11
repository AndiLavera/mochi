module Mochi::Helpers
  module Amber
    module RenderHandler

      macro display(view)
        render {{view}}
      end

      # macro render_user_new
      #   render("user/new.ecr")
      # end

      # macro render_user_show
      #   render("user/show.ecr")
      # end

      # macro render_user_create
      #   render("user/create.ecr")
      # end

      # macro render_user_edit
      #   render("user/edit.ecr")
      # end

      # macro render_session_new
      #   render("session/new.ecr")
      # end

      # macro render_session_show
      #   render("session/show.ecr")
      # end

      # macro render_session_edit
      #   render("session/edit.ecr")
      # end

      # macro render_recovery_new
      #   render("recovery/new.ecr")
      # end

      # macro render_invite_new
      #   render("invitable/new.ecr")
      # end

      # macro render_invite_edit
      #   render("invitable/edit.ecr")
      # end
    end
  end
end
