require "./generator"
require "./field"

module Mochi::CLI
  class Omniauthable < Generator
    command :omniauthable
    directory "#{__DIR__}/../templates/omniauthable"

    property fields : Array(Field)

    def initialize(name, fields, orm : String)
      super(name, nil)
      @fields = all_fields(fields)
      @orm = orm
      @migration_extension = @orm == "granite" ? "sql" : "cr"
    end

    def pre_render(directory, **args)
      add_routes
      inject_require_omniauth
    end

    private def add_routes
      add_routes :web, <<-ROUTES
        get "/omniauth/user/:provider", Omniauthable::UserController, :create
        get "/omniauth/user/:provider/callback", Omniauthable::UserController, :callback

        get "/omniauth/:provider", Omniauthable::SessionController, :create
        get "/omniauth/:provider/callback", Omniauthable::SessionController, :callback
      ROUTES
    end

    private def inject_require_omniauth
      filename = "./config/initializers/mochi.cr"
      initializer = File.read(filename)
      append_text = ""

      unless initializer.includes? "mochi/omniauth"
        append_text += require_omniauth
      end

      initializer += append_text
      File.write(filename, initializer)
    end

    private def require_omniauth
      <<-OMNIAUTH

      # Omniauth allows 5 different providers for OAuth
      # The providers currently supported are:
      # Google, Facebook, Github, Twitter & VK
      require "mochi/omniauth"
      Mochi::Omniauthable.setup do |config|
        # config.google_id = ENV["google_id"]
        # config.google_secret_key = ENV["google_key"]

        # config.facebook_id = ENV["facebook_id"]
        # config.facebook_secret_key = ENV["facebook_key"]

        # config.github_id = ENV["github_id"]
        # config.github_secret_key = ENV["github_key"]

        # config.twitter_id = ENV["twitter_id"]
        # config.twitter_secret_key = ENV["twitter_key"]

        # config.vk_id = ENV["vk_id"]
        # config.vk_secret_key = ENV["vk_key"]
      end
      require "mochi/omniauth/handler"
      OMNIAUTH
    end

    private def all_fields(fields)
      fields.map { |field| Field.new(field, database: config.database) } +
        auth_fields
    end

    private def auth_fields
      %w(email:string hashed_password:password).map do |f|
        Field.new(f, hidden: false, database: config.database)
      end
    end
  end
end
