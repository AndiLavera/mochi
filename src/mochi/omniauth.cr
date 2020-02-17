require "oauth"
require "oauth2"
require "./models/omniauthable/configuration"
require "./models/omniauthable/engine"
require "./models/omniauthable/provider"
require "./models/omniauthable/user"
require "./models/omniauthable/providers/**"
require "./controllers/omniauthable/**"

module Mochi::Omniauthable; end
