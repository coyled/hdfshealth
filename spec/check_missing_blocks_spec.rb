$:.unshift File.join(File.dirname(__FILE__), '../lib')

require 'hdfshealth'

RSpec.describe CheckMissingBlocks do
    it "Verifies there are no missing blocks" do
        test_jmx_file = 'file://' + File.dirname(__FILE__) + '/jmx/nn_blocks_not_missing.jmx'

        check = CheckMissingBlocks.new
        check.run(test_jmx_file)

        expect(check.status).to eq('OK')
    end

    it "Verifies there are missing blocks" do
        test_jmx_file = 'file://' + File.dirname(__FILE__) + '/jmx/nn_blocks_missing.jmx'

        check = CheckMissingBlocks.new
        check.run(test_jmx_file)

        expect(check.status).to eq('CRITICAL')
    end
end
