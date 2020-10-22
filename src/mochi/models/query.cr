module Mochi::Models
  # :nodoc:
  module Query
    module Granite
      macro included
        def self.find_by(controller_params : Amber::Validators::Params, column : Symbol, param : Symbol) : User?
          User.find_by({column => controller_params[param] })
        end
      end
    end

    module Jennifer
      macro included
        def self.find_by(controller_params : Amber::Validators::Params, column : Symbol, param : Symbol) : User?
          User.where { c(column.to_s) == controller_params[param] }.first
        end
      end
    end
  end
end
