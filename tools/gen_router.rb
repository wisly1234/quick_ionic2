require_relative 'table_help'
# require "table_help"


puts "check args:#{ARGV}"

folder, view_name = ARGV

VIEW_TEMEPLATE="
<ion-view view-title=\"\" class=\"\">

</ion-view>
"  
save_str(VIEW_TEMEPLATE, "#{folder}/templates/app/#{view_name}.html")
save_str(VIEW_TEMEPLATE, "#{folder}/templates/wap/#{view_name}.html")



# controllers_str="var g_controller = angular.module('starter.views', []);\n"

views = read_to_hash("#{folder}/config/views.json")
views ||= []
views << view_name

save_to_json(views, "#{folder}/config/views.json")