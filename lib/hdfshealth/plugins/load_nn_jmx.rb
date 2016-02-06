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
        uri = URI(namenode)
        if uri.scheme == 'file'
            jmx = File.read(uri.path)
        elsif uri.scheme == 'http' or uri.scheme == 'https'
            jmx = Net::HTTP.get(URI("#{namenode}"))
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
