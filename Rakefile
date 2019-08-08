require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require 'pry'
  require 'cryptoexchange'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/cryptoexchange\// }
    files.each { |file| load file }
  end

  ARGV.clear
  Pry.start
end

task :reset_cassette do
  require 'pry'
  puts ARGV
  exchange_name = ARGV.last
  if exchange_name.nil?
    puts "no exchange name given."
    next
  end
  puts exchange_name
  exchange_name = exchange_name.capitalize

  cassette_types = ["pairs", "ticker", "order_book", "trade"]

  cassette_paths = cassette_types.map do |cassette_type|
    "spec/cassettes/vcr_cassettes/#{exchange_name}/integration_specs_fetch_#{cassette_type}.yml"
  end

  cassette_paths.each do |path|
    puts path
    puts File.exists? path
    File.delete(path) if File.exist?(path)
    puts "#{path} deleted for #{exchange_name}"
  end
end
