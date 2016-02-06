module HDFSHealth
    class CLI

        def initialize(params = {})
            @namenode = params[:namenode]
        end

        def run
            HDFSHealth::Plugin.autorun_plugins.each do |plugin|
                check = plugin.new
                check.run(@namenode)

                puts check.status
                puts check.message
            end
        end

        def self.namenode
            @namenode
        end

    end
end
