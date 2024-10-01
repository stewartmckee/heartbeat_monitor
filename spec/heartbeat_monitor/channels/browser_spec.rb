# frozen_string_literal: true

# require './lib/heartbeat_monitor/channels/proc_instance'

describe '#browser' do
  it 'checks for invalid urls' do
    expect(HeartbeatMonitor::Channels::Browser.new({ url: 'http://192.168.99.222' }).running?[:running]).to be_falsey
  end
  it 'checks for valid url' do
    expect(HeartbeatMonitor::Channels::Browser.new({ url: 'http://icanhazip.com' }).running?[:running]).to be_truthy
  end
  context 'with css selectors' do
    it 'succeeds with match' do
      browser = HeartbeatMonitor::Channels::Browser.new({ url: 'https://cb.caseblocks.com/xg/#/login',
                                                          selector: "input[aria-label='Email Address']" })
      expect(browser.running?[:running]).to be_truthy
    end
    it 'fails without match' do
      browser = HeartbeatMonitor::Channels::Browser.new({ url: 'https://cb.caseblocks.com/xg/#/login',
                                                          selector: '#non-existant-id' })
      expect(browser.running?[:running]).to be_falsey
    end
  end
  it 'requires a url' do
    expect { HeartbeatMonitor::Channels::Browser.new({}.running?[:running]) }.to raise_error(StandardError)
  end
end
