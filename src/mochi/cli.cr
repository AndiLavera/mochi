require "cli"
require "yaml"
require "./version"
require "./cli/commands"

Mochi::CLI::MainCommand.run ARGV
