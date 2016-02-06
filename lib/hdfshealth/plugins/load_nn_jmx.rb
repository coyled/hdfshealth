class LoadNNJMX < HDFSHealth::Plugin

    @jmx = {}

    def self.jmx(namenode)

        unless @jmx[namenode]
            # fetch nn jmx here
            #@jmx[namenode] = foo
        end

        @jmx[namenode]

    end

end
