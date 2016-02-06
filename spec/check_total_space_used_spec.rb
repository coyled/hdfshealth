$:.unshift File.join(File.dirname(__FILE__), '../lib')

require 'hdfshealth'

RSpec.describe CheckTotalSpaceUsed do
    it "Verifies HDFS is using less than 60% of total space" do
        test_jmx_file = 'file://' + File.dirname(__FILE__) + '/jmx/nn_ok_space_usage.jmx'

        check = CheckTotalSpaceUsed.new
        check.run(test_jmx_file)

        expect(check.status).to eq('OK')
    end

    it "Verifies HDFS is using more than 70% of total space" do
        test_jmx_file = 'file://' + File.dirname(__FILE__) + '/jmx/nn_high_space_usage.jmx'

        check = CheckTotalSpaceUsed.new
        check.run(test_jmx_file)

        expect(check.status).to eq('CRITICAL')
    end
end
