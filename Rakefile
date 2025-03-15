require 'rake'
require 'rake/testtask'

ENV['TEST'] = 'true'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: :test
