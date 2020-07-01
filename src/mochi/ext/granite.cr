module Mochi::Extension
  module Orm
    macro find_klass_by(klass, column, param)
      {{klass.id}}.find_by({{column.id}}: resource_params[:{{param.id}}])
    end
  end
end
