module Mochi::Helpers
  abstract class Render
    def initialize(c : SessionController)
      @controller = c
    end

    def initialize(c : SessionController)
      @controller = c
    end

    abstract def user_new
    abstract def user_show
    abstract def user_edit

    forward_missing_to @controller
  end
end
