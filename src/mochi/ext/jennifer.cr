module Mochi::Extension
  module Orm
    macro find_klass_by(klass, column, param)
      {{klass.id}}.where { _{{column.id}} == {{param.id}} }
    end
  end
end
