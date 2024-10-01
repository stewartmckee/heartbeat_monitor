describe '#proc_instance' do
  context 'valid' do
    before(:each) do
      @process_list = [[1_234_222, 'test-pid-name']]
    end
    it 'pids' do
      proc_instance = HeartbeatMonitor::Channels::ProcInstance.new({ pid: 1_234_222 })
      allow(proc_instance).to receive(:process_table).and_return(@process_list)
      expect(proc_instance.running?[:running]).to be_truthy
    end
    it 'process' do
      proc_instance = HeartbeatMonitor::Channels::ProcInstance.new({ name: 'test-pid-name' })
      allow(proc_instance).to receive(:process_table).and_return(@process_list)
      expect(proc_instance.running?[:running]).to be_truthy
    end
  end
  context 'invalid' do
    it 'pids' do
      expect(HeartbeatMonitor::Channels::ProcInstance.new({ pid: 1_234_222 }).running?[:running]).to be_falsey
    end
    it 'process' do
      expect(HeartbeatMonitor::Channels::ProcInstance.new({ name: 'test-pid-name' }).running?[:running]).to be_falsey
    end
  end
  it 'requires a pid or name' do
    expect { HeartbeatMonitor::Channels::ProcInstance.new({}) }.to raise_error(StandardError)
  end
end
