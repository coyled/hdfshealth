#
# CheckTotalSpaceUsed: look at total % of HDFS space used.  complain
# if it's high.
#
class CheckTotalSpaceUsed < HDFSHealth::Plugin

    require_relative 'load_nn_jmx'

    def run(namenode)
        jmx = LoadNNJMX.jmx(namenode)

        total_space_used = jmx['FSNamesystem']['CapacityUsed'].to_i
        total_space = jmx['FSNamesystem']['CapacityTotal'].to_i
        pct_space_used = total_space_used.to_f / total_space.to_f

        if pct_space_used < 0.5
            @status = 'OK'
        elsif pct_space_used < 0.7
            @status = 'WARNING'
        else
            @status = 'CRITICAL'
        end

        @message = "#{'%.2f' % (pct_space_used * 100)}% of total space used (#{total_space_used} of #{total_space} bytes)"
    end

end
