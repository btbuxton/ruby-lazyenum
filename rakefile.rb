require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'
require 'rake/testtask'

spec = Gem::Specification.new do | s |
  s.name = 'LazyEnumerable'
  s.version = '0.0.4'
  s.author = 'Blaine Buxton'
  s.email = 'altodorado@blainebuxton'
  s.homepage = 'http://lazyenum.rubyforge.org/'
  s.rubyforge_project = 'lazyenum'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Functional programming with collections (Higher Order Methods)'
  s.files = FileList['{tests,lib}/**/*'].to_a
  s.require_path = 'lib'
  s.test_file = 'tests/lazy_enumerable_test_suite.rb'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
  pkg_need_zip = true
end

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['lazy_enumerable_test_suite.rb']
  t.verbose = true
end

task :all => [:clobber_package, :test, :gem]