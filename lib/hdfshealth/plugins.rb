#
# require all the plugins in the plugins dir
#

Dir[File.join(File.dirname(__FILE__), 'plugins/*.rb')].each do |file|
    require file
end
