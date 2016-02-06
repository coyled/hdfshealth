$:.unshift File.join(File.dirname(__FILE__), '../lib')

require 'hdfshealth'

RSpec.describe CheckSafeMode do
    it "Verifies HDFS safe mode is off" do
        test_jmx_file = 'file://' + File.dirname(__FILE__) + '/test_nn.jmx'

        check = CheckSafeMode.new
        check.run(test_jmx_file)

        expect(check.status).to eq('CRITICAL')
    end
end
