require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.pattern = "tests/test*.rb"
end

desc "Run tests"
task default: :test
