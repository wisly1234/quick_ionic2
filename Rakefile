def site_path; "~/workspace/quick_ionic2/tabs/app" end

desc "show help"
task :help do 
  puts "
  NOTICE: change the first line of Rakefile with your project folder
  1. rake init 
  --  init project folder
  2. rake module_add[my_module]
  -- add module to project 
  3. rake controller_add[my_controller]
  -- add controller to project
  4. rake view_add[my_view]
  -- add view to project
  "
end

desc "init basic app directory"
task :init do   
  ruby "-C. tools/init_project.rb #{site_path}"
end

desc "add pages foler just like rake g page page_name"
#command like  rake page_add[my-page-name] "
task :page_add, [:page_name] do |t, args|
  page_name = args[:page_name]
  puts "gen new page folder: #{page_name}, #{args}"
  ruby "-C. tools/gen_view.rb #{site_path} #{page_name}"
end

#command like: ionic g provider github-users
desc "add pages foler just like rake g page page_name"
#command like  rake page_add[my_page] "
task :provider_add, [:provider_name] do |t, args|
  provider_name = args[:provider_name]
  puts "gen new page folder: #{provider_name}, #{args}"
  puts "update app/app.core.scss of page"
  puts "you should import your page from app.ts manually"
  ruby "-C. tools/gen_view.rb #{site_path} #{provider_name}"
end



desc "add all module data like  rake module_add[my_module] "
task :module_add, [:module_name] do |t, args|
  module_name = args[:module_name]
  puts "get module_name: #{module_name}, #{args}"
  Rake::Task["controller_add"].invoke(module_name)
  Rake::Task["view_add"].invoke(module_name)
  # gen = "game-config/#{module_name}.json-gen.rb"
  # ruby "-C. -Ilib/cocs #{gen} #{design_dir}/Database/#{module_name}.xls"
end


desc "add controller module like  rake controller_add[my_controller] "
task :controller_add, [:controller_name] do |t, args|
  controller_name = args[:controller_name]
  puts "get controller_name: #{controller_name}, #{args}"
  ruby "-C. tools/gen_controller.rb #{site_path} #{controller_name}"
end



