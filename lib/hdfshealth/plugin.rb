module HDFSHealth
    class Plugin

        #
        # store a list of all the loaded plugins that have a run
        # method so we can run them later
        #
        @@autorun_plugins = []

        def self.method_added(method)
            if method == :run
                @@autorun_plugins << self
            end
        end

        def self.autorun_plugins
            @@autorun_plugins
        end

        def status
            @status
        end

        def message
            @message
        end

    end
end
