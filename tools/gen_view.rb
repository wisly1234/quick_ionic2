require_relative 'table_help'
# require "table_help"


puts "check args:#{ARGV}"

folder, view_name, controller_name = ARGV

VIEW_TEMEPLATE="
<ion-view view-title=\"\" class=\"\">
  <ion-content class=\"\">
    <h2>this is page #{view_name}</h2>
  </ion-content>
</ion-view>
"  
save_str(VIEW_TEMEPLATE, "#{folder}/templates/app/#{view_name}.html")
save_str(VIEW_TEMEPLATE, "#{folder}/templates/wap/#{view_name}.html")



# controllers_str="var g_controller = angular.module('starter.views', []);\n"
controller_name ||= view_name

views = read_to_hash("#{folder}/config/views.json")
views ||= []
views << {"name" => view_name, "controller" => controller_name}

save_to_json(views, "#{folder}/config/views.json")


puts "Don't forget to add an import for #{view_name}.scss in app/themes/app.core.scss:

  @import \"../pages/#{view_name}/#{view_name}.scss\";"