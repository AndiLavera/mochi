require "logger"

# :nodoc:
abstract class Command < Cli::Command
  def info(msg)
    # Mochi::CLI.logger.info msg, Class.name, :light_cyan
    log = Logger.new(STDOUT)
    log.info(msg)
  end

  def error(msg)
    # Mochi::CLI.logger.error msg, Class.name, :red

    log = Logger.new(STDOUT)
    log.error(msg)
  end
end
