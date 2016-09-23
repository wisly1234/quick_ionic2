require_relative 'table_help'
# require "table_help"


puts "check args:#{ARGV}"

folder, controller_name = ARGV

CONTROLLER_TEMEPLATE="
g_controller.controller('#{controller_name}Ctrl', function($scope) {

	
	});
"  
save_str(CONTROLLER_TEMEPLATE, "#{folder}/js/app/#{controller_name}_controller.js")
save_str(CONTROLLER_TEMEPLATE, "#{folder}/js/wap/#{controller_name}_controller.js")



controllers_str="var g_controller = angular.module('starter.controllers', []);\n"

controllers = read_to_hash("#{folder}/config/controllers.json")
controllers ||= []
controllers << controller_name

controllers.each do |one_controller|
	controllers_str += "document.write(\"<script src='js/app/#{one_controller}_controller.js'></script>\");\n"
end

save_str(controllers_str, "#{folder}/js/app/controllers.js")
save_str(controllers_str, "#{folder}/js/wap/controllers.js")
save_to_json(controllers, "#{folder}/config/controllers.json")