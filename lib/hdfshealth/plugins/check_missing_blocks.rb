class CheckMissingBlocks < HDFSHealth::Plugin

    require_relative 'load_nn_jmx'

    def run(namenode)
        jmx = LoadNNJMX.jmx(namenode)

        missing_blocks = jmx['FSNamesystem']['MissingBlocks'].to_i
        missing_single_replica_blocks = jmx['FSNamesystem']['MissingReplOneBlocks'].to_i

        if missing_blocks > 0 || missing_single_replica_blocks > 0
            @status = 'CRITICAL'
            @message = "there are missing blocks.  missing: #{missing_blocks}  missing" \
                       " from files with single replicas: #{missing_single_replica_blocks}"
        else
            @status = 'OK'
            @message = 'no reported missing blocks'
        end
    end

end
