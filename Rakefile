require 'rake/testtask'

require './lib/toy-robot.rb'


Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end

task :run do
  ToyRobot.new.run
end

task :default => :run
