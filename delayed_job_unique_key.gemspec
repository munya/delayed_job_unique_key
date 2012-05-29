# -*- encoding: utf-8 -*-
require File.expand_path('../lib/delayed_job_unique_key/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Oleg Muntyan"]
  gem.email         = ["omuntyan@gmail.com"]
  gem.description   = %q{Gem based on delayed job with active record and allows to prevent creating new job if already exists not running one with unique key}
  gem.summary       = %q{}
  gem.homepage      = "http://github.com/munya/delayed_job_unique_key"

  #gem.files         = `git ls-files`.split($\)
  gem.files         = Dir.glob('{lib}/**/*')
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "delayed_job_unique_key"
  gem.require_paths = ["lib"]
  gem.version       = DelayedJobUniqueKey::VERSION

  gem.add_runtime_dependency  'delayed_job_active_record',   '~>0.3.2'
end