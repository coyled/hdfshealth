module HDFSHealth
    class CLI

        def initialize(params = {})
            @namenode = params[:namenode]
            @output_format = params[:output_format]
        end

        def run
            #
            # run each of the plugins and output results from each
            #
            HDFSHealth::Plugin.autorun_plugins.each do |plugin|
                check = plugin.new
                check.run(@namenode)

                if check.status.nil?
                    status = 'UNKNOWN'
                else
                    status = check.status
                end

                if check.message.nil?
                    message = 'unknown'
                else
                    message = check.message
                end

                timestamp = Time.now.utc.to_s

                if @output_format == 'json'
                    # we're treating each line as a separate json
                    # object in case we want to send to some
                    # log/log aggregation service...
                    output = {
                        'timestamp' => timestamp,
                        'plugin'    => plugin,
                        'status'    => status,
                        'message'   => message
                    }.to_json
                elsif @output_format == 'human'
                    output = "[ #{timestamp} ] #{plugin} status: #{status}  #{message}"
                end

                puts output
            end
        end

        def self.namenode
            @namenode
        end

    end
end
