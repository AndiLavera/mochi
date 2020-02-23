# require "file_utils"

# module CLIHelper
#   BASE_ENV_PATH       = "./config/environments/"
#   ENV_CONFIG_PATH     = "#{TESTING_APP}/config/environments/"
#   CURRENT_ENVIRONMENT = ENV["AMBER_ENV"] ||= "test"
#   ENVIRONMENTS        = %w(development test)

#   def cleanup
#     Dir.cd CURRENT_DIR
#     if Dir.exists?(TESTING_APP)
#       FileUtils.rm_rf(TESTING_APP)
#     end
#   end

#   def prepare_test_app
#     cleanup
#     scaffold_app("#{TESTING_APP}", "-d", "sqlite")
#     #environment_yml(ENV["AMBER_ENV"], "#{Dir.current}/config/environments/")
#   end

#   def scaffold_app(app_name, *options)
#     system("amber new #{app_name}")
#     Dir.cd(app_name)
#   end
# end
