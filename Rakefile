require 'rake'
require 'rubygems'
require 'rake/rdoctask'
require 'spec/rake/spectask'

puts "\nGem: simple-tidy\n\n"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name        = 'simple-tidy'
    s.summary     = ''
    s.email       = 'remi@remitaylor.com'
    s.homepage    = 'http://github.com/devfu/simple-tidy'
    s.description = ''
    s.authors     = %w( remi )
    s.files       = FileList['[A-Z]*', '{lib,spec,bin,examples}/**/*'] 
    # s.add_dependency 'person-gemname'
    # s.executables << 'script'
    # s.rubyforge_project = 'gemname'
    # s.extra_rdoc_files = %w( README.rdoc )
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
end

# require 'hanna'
# require 'darkfish-rdoc'

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'simple-tidy'
  rdoc.options << '--line-numbers' << '--inline-source'
  # rdoc.options += ["--template=#{`allison --path`}"]  # sudo gem install allison
  # rdoc.options += %w( -f darkfish )                   # sudo gem install darkfish-rdoc
  # rdoc.options += %w( -T hanna )                      # sudo gem install mislav-hanna
  rdoc.options += %w( -m README.rdoc ) # the initial page displayed
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Confirm that gemspec is $SAFE'
task :safe do
  require 'yaml'
  require 'rubygems/specification'
  data = File.read('simple-tidy.gemspec')
  spec = nil
  if data !~ %r{!ruby/object:Gem::Specification}
    Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
  else
    spec = YAML.load(data)
  end
  spec.validate
  puts spec
  puts "OK"
end

task :default => :spec
