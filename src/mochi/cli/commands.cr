require "./config"
require "./commands/command"
require "./commands/*"
require "../version"

module Mochi::CLI
  class MainCommand < ::Cli::Supercommand
    command_name "mochi"
    version "Mochi CLI - v#{Mochi::VERSION}"

    class Help
      title "\nMochi CLI"
      header <<-EOS
        Mochi
      EOS

      footer <<-EOS
      Example:
        mochi generate auth user granite
        This generates & inserts the authentication module with the resource named as user and the for the granite orm.
      EOS
    end

    class Options
      version desc: "prints Mochi's version"

      help desc: "describe available commands and usages"

      # string ["-t", "--template"], desc: "preconfigure for selected template engine", any_of: %w(slang ecr), default: "ecr"
      # string ["-d", "--database"], desc: "preconfigure for selected database.", any_of: %w(pg mysql sqlite), default: "sqlite"
      # string ["-r", "--recipe"], desc: "use a named recipe. See documentation at https://docs.amberframework.org/amber/cli/recipes.", default: nil
    end
  end
end
