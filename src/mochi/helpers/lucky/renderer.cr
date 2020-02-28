module Mochi::Helpers
  class Renderer < BaseRenderer
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

    private def render(page_class, **named_args)
      {% raise "'render' in actions has been renamed to 'html'" %}
    end

    private getter view = IO::Memory.new
  end
end