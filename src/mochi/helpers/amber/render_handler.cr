module Mochi::Helpers
  module Amber
    module RenderHandler

      macro display(view)
        render {{view}}
      end

      # macro render_invite_new
      #   render("invitable/new.ecr")
      # end

      # macro render_invite_edit
      #   render("invitable/edit.ecr")
      # end
    end
  end
end
