require "jennifer"
require "jennifer/adapter/postgres"
Jennifer::Config.read("./spec/support/jennifer_database.yml", "test")
Jennifer::Config.configure do |conf|
  conf.logger = Log.for("db", :warn)
end

require "granite"
require "granite/adapter/pg"
Granite::Connections << Granite::Adapter::Pg.new(name: "postgres", url: "postgresql://mochi:mochi@localhost/mochi_test")
