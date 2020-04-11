module Mochi::Helpers
  module Granite
    module QueryHandler
      macro find_by_email
        User.find_by(email: fetch("email"))
      end
    end
  end
end