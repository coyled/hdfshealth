class LoadNNJMX < HDFSHealth::Plugin

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
        jmx =  Net::HTTP.get(URI("http://#{namenode}/jmx"))
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
