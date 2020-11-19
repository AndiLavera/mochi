require "oauth"
require "oauth2"
require "./models/omniauthable/configuration"
require "./models/omniauthable/engine"
require "./models/omniauthable/provider"
require "./models/omniauthable/user"
require "./models/omniauthable/providers/**"
require "./controllers/omniauthable/*"

# TODO
# Description
#
# Columns:
#
# - `uid : String?` - Identification used for sign-in verification (These user's do not have a `password_digest` or `email`)
#
# Configuration:
#
# Examples:
#
#
module Mochi::Omniauthable; end
