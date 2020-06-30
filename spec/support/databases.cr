require "jennifer"
require "jennifer/adapter/postgres"
Jennifer::Config.read("./spec/support/jennifer_database.yml", "test")
Jennifer::Config.configure do |conf|
  conf.logger.level = Logger::WARN
end

require "granite"
require "granite/adapter/pg"
Granite::Connections << Granite::Adapter::Pg.new(name: "postgres", url: "postgresql://postgres:@localhost/mochi_test")
#Granite.settings.logger.not_nil!.progname = "Granite"
