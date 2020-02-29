module Mochi::Helpers
  class RenderHandler < Render
    include Lucky::Exposable
    include Lucky::Renderable

    def user_new
      html User::NewPage
    end

    def user_show
      html User::ShowPage
    end

    def user_edit
      html User::EditPage
    end

    private getter view = IO::Memory.new
  end
end