# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{entity_storage}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Siler"]
  s.date = %q{2009-09-20}
  s.description = %q{An easy to use, persistent Key/Value store for any Ruby on Rails project. Designed to store config values & application wide state that need to survive server restarts.

Additionally, allows users to set a list of default keys that auto-initiliazes baseline key/value pairs in the database for easy initialization.}
  s.email = ["joshua.siler@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/entity_storage.rb", "script/console", "script/destroy", "script/generate", "config/database.yml", "test/test_entity_storage.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/eatenbyagrue/entity_storage}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{entity_storage}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{An easy to use, persistent Key/Value store for any Ruby on Rails project}
  s.test_files = ["test/test_entity_storage.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.2.2"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.2.2"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.2.2"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
