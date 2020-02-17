require "../generators"

module Mochi::CLI
  class_property color = true

  class MainCommand < ::Cli::Supercommand
    command "g", aliased: "generate"

    ACCEPTABLE_ORMS = ["g", "granite", "j", "jennifer"]
    ORM_FULL_NAME   = {"g" => "granite",
                       "j" => "jennifer"}

    class Generate < Command
      class Options
        arg "type", desc: "auth, omniauth, error", required: true
        arg "name", desc: "name of resource", required: false
        arg "orm", desc: "select orm (jennifer, granite)", required: true
        arg_array "fields", desc: "user:reference name:string body:text age:integer published:bool"
        bool "--no-color", desc: "disable colored output", default: false
        bool ["-y", "--assume-yes"], desc: "Assume yes to disable interactive mode", default: false
        help
      end

      class Help
        header "Generates application based on templates"
        caption "Generates application based on templates"
      end

      def run
        ensure_name_argument!
        ensure_orm_argument!
        full_orm_name = modify_orm_name
        generator = Generators.new(args.name, ".", args.fields, full_orm_name)
        generator.generate(args.type, options)
      end

      def recipe
        CLI.config.recipe
      end

      private def ensure_name_argument!
        unless args.name?
          error "Parsing Error: The NAME argument is required."
          exit! help: true, error: true
        end
      end

      private def ensure_orm_argument!
        unless args.orm?
          error "Parsing Error: The ORM argument is required."
          exit! help: true, error: true
        end

        unless ACCEPTABLE_ORMS.includes?(args.orm.downcase)
          error "Parsing Error: This selected ORM is not supported. Supported types are: Jennifer(alias j) and Granite(alias g)"
          exit! help: true, error: true
        end
      end

      private def modify_orm_name
        args.orm.size == 1 ? ORM_FULL_NAME[args.orm] : args.orm
      end

      class Help
        caption "generate Amber classes"
      end
    end
  end
end
