require "./generator"
require "./field"

module Mochi::CLI
  class Recoverable < Generator
    command :recoverable
    directory "#{__DIR__}/../templates/recoverable"

    property fields : Array(Field)
    getter migration_extension : String

    def initialize(name, fields, orm : String)
      super(name, nil)
      # @fields = all_fields(fields)
      @orm = orm
      @migration_extension = @orm == "granite" ? "sql" : "cr"
    end

    def pre_render(directory, **args)
      # add_plugs
      # inherit_plug :web, :auth
      add_routes
      # add_dependencies
      # inject_application_controller_methods
    end

    private def add_routes
      add_routes :web, <<-ROUTES
        get "/reset/password", PasswordController, :new
        post "/reset/password", PasswordController, :create
        get "/confirm/reset/password", PasswordController, :update
      ROUTES
    end
  end
end
