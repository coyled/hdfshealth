class CheckSafeMode < HDFSHealth::Plugin

    require_relative 'load_nn_jmx'

    def run(namenode)
        jmx = LoadNNJMX.jmx(namenode)

        if jmx['NameNodeInfo']['Safemode'].empty?
            @status = 'OK'
            @message = 'NN not in safe mode'
        else
            @status = 'CRITICAL'
            @message = jmx['NameNodeInfo']['Safemode']
        end
    end

end
