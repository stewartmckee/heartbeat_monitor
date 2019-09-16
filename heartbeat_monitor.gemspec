# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heartbeat_monitor/version'

Gem::Specification.new do |spec|
  spec.name          = 'heartbeat_monitor'
  spec.version       = HeartbeatMonitor::VERSION
  spec.authors       = ['Stewart McKee']
  spec.email         = ['stewart@theizone.co.uk']

  spec.summary       = 'Montioring gem designed to internally within a protected system and emit a heartbeat request to external montiring services'
  spec.description   = 'Designed to run within a protected network that external monitoring systems do not have access to, it will emit a heartbeat request to an external system based on an internal request to the service being monitored'
  spec.homepage      = 'https://github.com/stewartmckee/heartbeat_monitor'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/stewartmckee/heartbeat_monitor'
  spec.metadata['changelog_uri'] = 'https://github.com/stewartmckee/heartbeat_monitor/CHANGE.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
