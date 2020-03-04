require "jennifer_sqlite3_adapter"
Jennifer::Config.configure do |conf|
  conf.adapter = "sqlite3"
  conf.host = "."
  conf.db = "jennifer_test.db"
end
