require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false

  # added per Josh
  t.test_files = FileList['test/**/*_test.rb']
  puts FileList['test/**/*_test.rb']
end

task default: :test
task spec: :test
