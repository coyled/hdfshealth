module HDFSHealth
    class CLI

        def initialize(params = {})
            @namenode = params[:namenode]
        end

        def run
            #
            # run each of the plugins and output results from each
            #
            HDFSHealth::Plugin.autorun_plugins.each do |plugin|
                check = plugin.new
                check.run(@namenode)

                # FIX
                if check.status.empty?
                    status = 'UNKNOWN'
                else
                    status = check.status
                end

                # FIX
                if check.message.empty?
                    message = 'unknown'
                else
                    message = check.message
                end

                timestamp = Time.now.utc.to_s

                puts "[ #{timestamp} ] #{plugin} status: #{status}  #{message}"
            end
        end

        def self.namenode
            @namenode
        end

    end
end
