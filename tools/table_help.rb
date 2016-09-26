#!/usr/bin/env ruby
# coding:utf-8

require 'roo'
require 'json'
require 'ostruct'
require 'iconv'
# require 'george'
require 'colorize'

BOOLEAN = {
  'y' => true,
  'n' => false,
  'Y' => true,
  'N' => false,
  'true' => true,
  'false' => false
}

$sheet = begin
           Roo::Excel.new(ARGV[0])
         rescue
           nil
         end

if $sheet
  $index = 2
  $index = 0 if $sheet.sheets.length <= 2

  $sheet.default_sheet = $sheet.sheets[$index]
  if $sheet.default_sheet
    $header = begin
                $sheet.row(3)
              rescue
                nil
              end
    if $header
      $header = $header.map do |x|
        x.strip if x && x.is_a?(String)
      end

      $names = ::Hash[$sheet.row(3).map.with_index { |x, index| [x.to_s, index] }]
    end
  end
end

def select_sheet(index, head_row)
  $sheet.default_sheet = $sheet.sheets[index]
  $header = $sheet.row(head_row)
  $header = $header.map do |x|
    x.strip if x && x.is_a?(String)
  end
end

def numeric?(value)
  true if Float(value)
rescue
  false
end

def get_header(row)
  header = $sheet.row(row)
  header.map do |x|
    x.strip if x && x.is_a?(String)
  end
end

def get_effbits
  JSON.parse(IO.read('game-config/effbits.json'))
end

def get_statebits
  JSON.parse(IO.read('game-config/statebits.json'))
end

def read_to_hash(file_name)
  JSON.parse(IO.read("#{file_name}"))
end

def read_file(file_name)
  IO.read("#{file_name}")
end

def remove_config(file_name)
  File.delete("game-config/#{file_name}.json")
end

def is_nil?(value)
  value.to_s.strip == 'nil'
end

def boolean?(value)
  BOOLEAN[value.to_s.strip] != nil
end

def parse(value)
  if numeric?(value)
    str = value.to_s
    if str =~ /.0$/
      return value.to_i
    else
      if str.include?('.')
        return value.to_f
      else
        return value.to_i
      end
    end
  elsif boolean?(value)
    return BOOLEAN[value.to_s.strip]
  elsif is_nil?(value)
    return nil
  else
    return value.to_s.strip
  end
end

def parse_value(key, value)
  str = value.to_s
  if key.to_s =~ /color/
    if numeric?(value)
      return value.to_i.to_s
    else
      return str
    end
  elsif key.to_s == 'id'
    return value.to_s
  else
    return parse(value)
  end
end


def save_str(str, file)
  File.open("#{file}", 'w') do |f|
    f.write(str)
  end
end

def save_to_json(data, file)
  json = JSON.pretty_generate(data).to_s.strip
  puts("check data :#{json},#{file}")
  begin
    File.open("#{file}", 'w') do |f|
      f.write(json)
    end
  rescue Exception=>e
  # handle e
    puts "Exception:#{e}"
  end

end

def save_processed_json(name, hs)
  hs.delete_empty_key!
  system('mkdir -p game-config-processed')
  if hs.is_a?(::Hash)
    hs.each do |_k, v|
      v.delete_if { |_k1, v1| v1.nil? } if v.is_a?(::Hash)
      v.delete_if { |k1, v1| k1 !~ /desc|name|icon|text|type|param/ && v1.to_s.empty? } if v.is_a?(::Hash)
    end
  end

  json = JSON.pretty_generate(hs).to_s.strip
  File.open("game-config-processed/#{name}.json", 'w+') do |f|
    f.write(json)
  end
  puts "generated game-config-processed/#{name}.json".colorize(:green)
end

def to_vector3(string)
  to_zip_float([:x, :y, :z], string)
end

def to_zip_float(arr, string)
  ::Hash[arr.zip(to_float_array(string))]
end

def to_zip_int(arr, string)
  ::Hash[arr.zip(to_int_array(string))]
end

def to_float_array(string)
  to_array(string).map { |x| x.to_f.round(2) }
end

def to_int_array(string)
  to_array(string).map(&:to_i)
end

def to_array(string)
  string.to_s.strip.split(/[,，;；]/).map(&:strip)
end

def to_array_uniq(string)
  list = to_array(string)
  list |= list
  list
end

def world_deg_to_game_deg(wdeg)
  wdeg.to_i
end

def fail_on_errors(errors)
  if errors.is_a?(::Array)
    puts errors.join("\n").colorize(:red) unless errors.empty?
    fail 'please fix above errors' unless errors.empty?
  end
end

def prefab_exists?(dir, file)
  prefab = dir + '/' + file + '.prefab'
  File.exist?(prefab)
end

def put_errors(errors, color = :red)
  if errors.is_a?(::Array)
    puts errors.join("\n").colorize(color) unless errors.empty?
  end
end

def find_dyn_block_npcs(inout_res, dyn_npcs, dynamic_npcs_cfg)
  tmp_table = {}
  dyn_npcs.each do |dnpcid|
    dntype = dynamic_npcs_cfg[dnpcid]
    next unless dntype && dntype.kind == 'block'
    city_tid = dntype.city_tid
    dntype.npcs.each do |npcid|
      tmp_table[npcid] = {
        'tid' => npcid,
        'city_tid' => city_tid
      }
    end
  end
  inout_res['dyn_block_npcs'] = tmp_table
end
