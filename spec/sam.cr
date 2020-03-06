require "jennifer"
require "./support/databases"

require "./db/jennifer_migrations/*"
require "sam"
require "jennifer/sam"
load_dependencies "jennifer"
Sam.help
