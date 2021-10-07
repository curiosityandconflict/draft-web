namespace :test do
  desc 'Run tests with coverage'
  task :coverage do
    require 'simplecov'
    SimpleCov.start 'rails'

    ENV['DISABLE_SPRING'] = '1'
    Rake::Task['test'].invoke
  end
end
