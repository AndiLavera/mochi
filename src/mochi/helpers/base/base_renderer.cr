module Mochi::Helpers
  abstract class BaseRenderer
    def initialize(c : UserController)
      @controller = c
    end

    abstract def user_new
    abstract def user_show
    abstract def user_edit

    forward_missing_to @controller
  end
end