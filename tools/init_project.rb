require_relative 'table_help'

puts "check init project args:#{ARGV}"

folder = ARGV[0]

folder_list = ["js/wap", "js/app", "templates/wap", "templates/app"]

folder_list.each do |single_folder|
  Dir.mkdir("#{folder}/#{single_folder}") unless  (File.exist?("#{folder}/#{single_folder}"))
end
 	
Dir.mkdir("#{folder}/config") unless  (File.exist?("#{folder}/config"))


save_to_json([], "#{folder}/config/controllers.json")
save_to_json([], "#{folder}/config/services.json")
save_to_json([], "#{folder}/config/views.json")


def get_app_str(folder) 
"
// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
var app = angular.module('starter', ['ionic', 'starter.controllers', 'starter.services'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
});

document.write(\"<script src='js/#{folder}/router.js'></script>\");
"
end
save_str(get_app_str("app"), "#{folder}/js/app/app.js")
save_str(get_app_str("wap"), "#{folder}/js/wap/app.js")

CONTROLLER_TEMPLATE = "
var g_controller = angular.module('starter.controllers', []);
"
save_str(CONTROLLER_TEMPLATE, "#{folder}/js/app/controllers.js")
save_str(CONTROLLER_TEMPLATE, "#{folder}/js/wap/controllers.js")
