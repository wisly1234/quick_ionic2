require_relative 'table_help'

puts "check init project args:#{ARGV}"

folder = ARGV[0]

folder_list = ["models", "providers"]

folder_list.each do |single_folder|
  Dir.mkdir("#{folder}/#{single_folder}") unless  (File.exist?("#{folder}/#{single_folder}"))
end
 	
template = read_file("#{folder}/theme/app.core.scss")
template += "\n//AppCoreFlat  -- added by wisly. NEVER Change this line"
save_str(template, "#{folder}/theme/app.core.scss")

# save_str(get_app_str("wap"), "#{folder}/js/wap/app.js")

# CONTROLLER_TEMPLATE = "
# var g_controller = angular.module('starter.controllers', []);
# "
# save_str(CONTROLLER_TEMPLATE, "#{folder}/js/app/controllers.js")
# save_str(CONTROLLER_TEMPLATE, "#{folder}/js/wap/controllers.js")
