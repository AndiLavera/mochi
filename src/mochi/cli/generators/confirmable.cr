require "./generator"
require "./field"

module Mochi::CLI
  class Confirmable < Generator
    command :confirmable
    directory "#{__DIR__}/../templates/confirmable"

    property fields : Array(Field)
    getter migration_extension : String

    def initialize(name, fields, orm : String)
      super(name, nil)
      @fields = all_fields(fields)
      @orm = orm
      @migration_extension = @orm == "granite" ? "sql" : "cr"
    end

    def pre_render(directory, **args)
      add_routes
      # inject_require_confirmable
    end

    private def add_routes
      add_routes :web, <<-ROUTES
        get "/registration/confirm", RegistrationController, :update
      ROUTES
    end

    private def all_fields(fields)
      fields.map { |field| Field.new(field, database: config.database) } +
        confirm_fields
    end

    private def confirm_fields
      %w(email:string password_digest:password).map do |f|
        Field.new(f, hidden: false, database: config.database)
      end
    end

    private def inject_require_confirmable
      filename = "./config/initializers/mochi.cr"
      initializer = File.read(filename)
      append_text = ""

      unless initializer.includes? "mochi/confirmable/confirmable"
        append_text += require_confirmable
      end

      initializer += append_text
      File.write(filename, initializer)
    end

    private def require_confirmable
      <<-CONFIRM


      # Adds Confirmable
      # Confirmable sends an email to confirm the user
      # Users cannot sign in until they have been confirmed(configurable)
      require "mochi/confirmable/confirmable"
      CONFIRM
    end
  end
end
