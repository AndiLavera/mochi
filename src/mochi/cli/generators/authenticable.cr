require "./generator"
require "./field"

module Mochi::CLI
  class Authenticable < Generator
    command :authenticable
    directory "#{__DIR__}/../templates/authenticable"

    property fields : Array(Field)
    getter migration_extension : String

    def initialize(name, fields, orm : String)
      super(name, nil)
      @fields = all_fields(fields)
      @orm = orm
      @migration_extension = @orm == "granite" ? "sql" : "cr"
    end

    def pre_render(directory, **args)
      add_plugs
      inherit_plug :web, :auth
      add_routes
      add_dependencies
      inject_application_controller_methods
    end

    private def add_routes
      add_routes :web, <<-ROUTES
          get "/signin", SessionController, :new
          post "/session", SessionController, :create
          get "/signup", #{class_name}Controller, :new
          post "/registration", #{class_name}Controller, :create
      ROUTES

      add_routes :auth, <<-ROUTES
          get "/profile", #{class_name}Controller, :show
          get "/profile/edit", #{class_name}Controller, :edit
          patch "/profile", #{class_name}Controller, :update
          get "/signout", SessionController, :destroy
      ROUTES
    end

    private def add_plugs
      add_plugs :web, <<-PLUGS
        plug Current#{class_name}.new
      PLUGS
      add_plugs :auth, <<-PLUGS
        plug Authenticate.new
      PLUGS
    end

    private def inherit_plug(base, target)
      routes = File.read("./config/routes.cr")
      pipes = routes.match(/pipeline :#{base.to_s} do(.+?)end/m)
      return unless pipes

      replacement = <<-PLUGS
        pipeline :#{base.to_s}, :#{target.to_s} do#{pipes[1]}
        end
      PLUGS
      File.write("./config/routes.cr", routes.gsub(pipes[0], replacement))
    end

    private def add_dependencies
      add_dependencies <<-DEPENDENCY
      require "../src/models/**"
      require "../src/pipes/**"
      DEPENDENCY
    end

    private def inject_application_controller_methods
      filename = "./src/controllers/application_controller.cr"
      controller = File.read(filename)
      append_text = ""

      unless controller.includes? "property current_#{@name}"
        append_text += current_method_definition
      end

      append_text = "#{append_text}\nend\n"
      controller = controller.gsub(/end\s*\Z/, append_text)
      File.write(filename, controller)
    end

    private def current_method_definition
      <<-AUTH

        def current_#{@name}
          context.current_#{@name}
        end
      AUTH
    end

    private def all_fields(fields)
      fields.map { |field| Field.new(field, database: config.database) } +
        auth_fields +
        timestamp_fields
    end

    private def auth_fields
      %w(email:string password_digest:password).map do |f|
        Field.new(f, hidden: false, database: config.database)
      end
    end

    private def timestamp_fields
      %w(created_at:time updated_at:time).map do |f|
        Field.new(f, hidden: true, database: config.database)
      end
    end
  end
end
