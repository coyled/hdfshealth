module HDFSHealth
    class Plugin

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
