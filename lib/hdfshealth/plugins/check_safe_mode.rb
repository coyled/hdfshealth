class CheckSafeMode < HDFSHealth::Plugin

    require_relative 'load_nn_jmx'

    def run(namenode)
        jmx = LoadNNJMX.jmx(namenode)

        @message = ''
        @status = ''
    end

end
