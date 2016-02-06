class CheckLastCheckpointTime < HDFSHealth::Plugin

    require_relative 'load_nn_jmx'

    def run(namenode)
        jmx = LoadNNJMX.jmx(namenode)

        # we see LastCheckpointTime in milliseconds but want it in seconds...
        last_checkpoint_time = jmx['FSNamesystem']['LastCheckpointTime'].to_i / 1000
        now = Time.now.to_i

        last_checkpoint_age = now - last_checkpoint_time

        if last_checkpoint_age < 43200
            @status = 'OK'
        elsif last_checkpoint_age < 86400
            @status = 'WARNING'
        else
            @status = 'CRITICAL'
        end

        @message = "last checkpoint is at least #{last_checkpoint_age / 3600} hours old"
    end

end
