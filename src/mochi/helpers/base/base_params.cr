module Mochi::Helpers
  abstract class BaseParams
    def initialize(c : UserController)
      @controller = c
    end

    abstract def validate
    abstract def find_param(param)

    forward_missing_to @controller
  end
end