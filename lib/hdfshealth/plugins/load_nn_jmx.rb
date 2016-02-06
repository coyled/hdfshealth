#
# load namenode /jmx output for use by other plugins
#
class LoadNNJMX < HDFSHealth::Plugin

    require 'uri'
    require 'net/http'
    require 'json'

    @jmx = {}

    def self.jmx(namenode)
        unless @jmx[namenode]
            self.fetch_jmx(namenode)
        end

        @jmx[namenode]
    end

    def self.fetch_jmx(namenode)
        uri = URI.parse(namenode)
        if uri.scheme == 'file'
            begin
                jmx = File.read(uri.path)
            rescue Errno::ENOENT
                print 'file not found.  exiting...'
                exit(1)
            end
        elsif uri.scheme == 'http' or uri.scheme == 'https'
            begin
                http = Net::HTTP.new(uri.host, uri.port)
                http.open_timeout = 5

                if uri.scheme == 'https'
                    http.use_ssl = true
                end

                response = http.request(Net::HTTP::Get.new(uri.request_uri))

                jmx = response.body
            rescue Net::OpenTimeout
                print 'timeout trying to retrieve JMX data from namenode.' \
                      'did you use the correct hostname/port?  exiting...'
                exit(1)
            end
        end
        stats = JSON.parse(jmx)

        stats['beans'].each do |data|
            self.parse_jmx(namenode, data)
        end
    end

    def self.parse_jmx(namenode, data)
        @jmx[namenode] ||= {}

        if data['name'] == 'Hadoop:service=NameNode,name=FSNamesystem'
            @jmx[namenode]['FSNamesystem'] ||= data
        elsif data['name'] == 'Hadoop:service=NameNode,name=NameNodeInfo'
            @jmx[namenode]['NameNodeInfo'] ||= data
        end
    end

end
