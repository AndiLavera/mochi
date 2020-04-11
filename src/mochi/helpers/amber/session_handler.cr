module Mochi::Helpers
  module Amber
    module SessionHandler
      macro session_create(key, value)
        session[{{key}}] = {{value}}
      end

      macro session_destroy(key)
        session.delete({{key}})
      end
    end
  end
end
