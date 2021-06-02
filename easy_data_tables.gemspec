# frozen_string_literal: true

require_relative 'lib/easy_data_tables/version'

Gem::Specification.new do |spec|
  spec.name          = 'easy_data_tables'
  spec.version       = EasyDataTables::VERSION
  spec.authors       = ['Pablo Curell']
  spec.email         = ['pablocm90@gmail.com']

  spec.summary       = 'Gem to easily create data tables'
  spec.description   = 'Create fast tables based on the models of your db'
  spec.homepage      = 'https://github.com/pablocm90/easy_data_tables'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/pablocm90/easy_data_tables'
  spec.metadata['changelog_uri'] = 'https://github.com/pablocm90/easy_data_tables'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
