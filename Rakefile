require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # no rspec available
end

begin
  require 'yard'

  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
    t.options = ['--no-private', '--protected', '--output-dir', 'doc']
    t.stats_options = ['--list-undoc']
  end

  desc "Generate documentation and open in browser"
  task :doc_open => :yard do
    system "open doc/index.html" if RUBY_PLATFORM =~ /darwin/
    system "xdg-open doc/index.html" if RUBY_PLATFORM =~ /linux/
  end
rescue LoadError
  # yard not available
end
