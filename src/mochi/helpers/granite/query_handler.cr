module Mochi::Helpers
  module Granite
    module QueryHandler
      macro find_by_email
        User.find_by(email: fetch("email"))
      end

      macro find_klass_by(klass, column, param)
        {{klass.id}}.find_by({{column.id}}: fetch({{param.id.stringify}}))
      end
    end
  end
end
