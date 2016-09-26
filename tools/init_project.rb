require_relative 'table_help'

puts "check init project args:#{ARGV}"

folder = ARGV[0]

folder_list = ["models", "providers"]
folder_list.each do |single_folder|
  Dir.mkdir("#{folder}/#{single_folder}") unless  (File.exist?("#{folder}/#{single_folder}"))
  puts "add foler #{folder}/#{single_folder}"
end
 	
template = read_file("#{folder}/theme/app.core.scss")
template += "\n//AppFlag  -- added by wisly. DO NEVER Change this line"
save_str(template, "#{folder}/theme/app.core.scss")


template = read_file("#{folder}/app.ts")
# puts "check template:#{template}"
template = template.gsub("@Component", "//AppFlag  -- added by wisly. DO NEVER Change this line \n\n\n@Component")
save_str(template, "#{folder}/app.ts")


