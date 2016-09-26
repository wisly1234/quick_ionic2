require_relative 'table_help'
# require "table_help"


puts "check args:#{ARGV}"

folder, view_name, controller_name = ARGV
view_names = view_name.split("-")
class_name = ""
view_names.each do |sub_view|
	class_name = "#{class_name}#{sub_view.capitalize}"
end
class_name = "#{class_name}Page"
final_folder = "#{folder}/#{view_name}"
template_folder = "templates/pages"
Dir.mkdir("#{final_folder}") unless  (File.exist?("#{final_folder}"))


template = read_file("#{template_folder}/page.html")
template = template.gsub("ViewName", "#{view_name}")
template = template.gsub("ClassName", "#{class_name}")
save_str(template, "#{final_folder}/#{view_name}.html")

template = read_file("#{template_folder}/page.scss")
template = template.gsub("ViewName", "#{view_name}")
template = template.gsub("ClassName", "#{class_name}")
save_str(template, "#{final_folder}/#{view_name}.scss")

template = read_file("#{template_folder}/page.ts")
template = template.gsub("ViewName", "#{view_name}")
template = template.gsub("ClassName", "#{class_name}")
save_str(template, "#{final_folder}/#{view_name}.ts")


template = read_file("#{folder}/app.ts")
# puts "check template:#{template}"
template = template.gsub("//AppFlag", "import { #{class_name} } from './pages/#{view_name}/#{view_name}'; \n\n\n//AppFlag")
save_str(template, "#{folder}/app.ts")


template = read_file("#{folder}/theme/app.core.scss")
template += template.gsub("//AppFlag","@import \"../pages/#{view_name}/#{view_name}\"; \n//AppFlag")
save_str(template, "#{folder}/theme/app.core.scss")


