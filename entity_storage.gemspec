# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{entity_storage}
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Siler"]
  s.date = %q{2009-09-23}
  s.description = %q{An easy to use Key/Value store for any Ruby on Rails project. Like Memcache, only persistent. Stores config values &amp; application wide state in the database in order to survive server restarts.

Designed to allow you to add persistent value storage to any Rails project in about 5 minutes.

Additionally, allows users to set a list of default keys that auto-initializes baseline key/value pairs in the database for easy initialization.}
  s.email = ["joshua.siler@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/entity_storage.rb", "script/console", "script/destroy", "script/generate", "config/database.yml", "test/test_entity_storage.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/eatenbyagrue/entity_storage}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{entity-storage}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An easy to use Key/Value store for any Ruby on Rails project}
  s.test_files = ["test/test_entity_storage.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0.beta4"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0.beta4"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0.beta4"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end

end
