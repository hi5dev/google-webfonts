# coding: utf-8
# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs += %w[lib test]
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test
