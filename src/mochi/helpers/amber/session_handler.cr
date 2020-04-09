module Mochi::Helpers
  module SessionHandler
    def session_create(key, value)
      session[key] = value
    end

    def session_destroy(key)
      session.delete(key)
    end
  end
end
