require 'rake/testtask'
require 'optparse'

require './lib/roboto.rb'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end

task :interactive do
  InteractiveRobot.new.run
end

task :automatic do
  options = {:input => nil}
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: rake automatic [options]"
    opts.on("-i", "--input file", String) do |file|
      options[:input] = file
    end
  end

  parser.parse!

  AutomaticRobot.new.run(options[:input])
  exit
end

task :default => :interactive
