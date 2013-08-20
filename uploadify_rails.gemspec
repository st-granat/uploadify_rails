# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uploadify_rails/version'

Gem::Specification.new do |gem|
  gem.license       = "MIT"
  gem.name          = "uploadify_rails"
  gem.version       = UploadifyRails::VERSION
  gem.authors       = ["Andrey"]
  gem.email         = ["railscode@gmail.com"]
  gem.description   = "Rails 3 multi upload with flash based Uploadify and Rails assets pipeline"
  gem.summary       = "Rails 3 multi upload with flash based Uploadify and Rails assets pipeline"
  gem.homepage      = "https://github.com/st-granat/uploadify_rails"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "mime-types", ">= 1.21" # :require => "mime/types"
  gem.add_dependency "flash_cookie_session", ">= 1.1.4"
  gem.add_dependency "nested_form", ">= 0.3.1"
  gem.add_dependency "renderer", ">= 0.0.14"
end
