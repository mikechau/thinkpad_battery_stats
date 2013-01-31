# Ruby script to display ThinkPad Battery Stats
# Inspired by: http://www.thinkwiki.org/wiki/Battery.rb
# More Info: http://www.thinkwiki.org/wiki/Tp_smapi#Battery_status_features

def getFileValue(filename)
  file = File.new(filename,"r")
  content = file.gets
  file.close
  content = content.delete "\n"
end

def bat_collect(categories)
  listing = Dir["/sys/devices/platform/smapi/BAT0/*"]
  listing.each do |type|
    category = File.basename(type)
    categories.merge!(category => type)
  end
end

def bat_display(statistics)
  statistics.each do |key, value|
    info = getFileValue(value)
    if info != nil
      puts "#{key}: #{info}"
    end
  end
end

begin
  battery_categories = Hash.new
  bat_collect(battery_categories)
  bat_display(battery_categories)
end