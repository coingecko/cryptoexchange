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

task :add_exchange do
  exchange_name = ARGV.last
   
  if ARGV.count == 2
    FileUtils.mkdir "lib/cryptoexchange/exchanges/#{exchange_name}/"
    FileUtils.mkdir "lib/cryptoexchange/exchanges/#{exchange_name}/services/"
    FileUtils.mkdir "spec/exchanges/#{exchange_name}/"
    FileUtils.mkdir "spec/exchanges/#{exchange_name}/integration/"

    File.new("lib/cryptoexchange/exchanges/#{exchange_name}/market.rb", "a")
    File.new("lib/cryptoexchange/exchanges/#{exchange_name}/services/pairs.rb", "a")
    File.new("lib/cryptoexchange/exchanges/#{exchange_name}/services/market.rb", "a")
    File.new("lib/cryptoexchange/exchanges/#{exchange_name}/services/order_book.rb", "a")
    File.new("lib/cryptoexchange/exchanges/#{exchange_name}/services/trades.rb", "a")

    File.new("spec/exchanges/#{exchange_name}/market_spec.rb", "a")
    File.new("spec/exchanges/#{exchange_name}/integration/market_spec.rb", "a")

    task puts "#{exchange_name} create successfully"
  else
    task puts "Please insert correct exchange name"
  end

  task exchange_name.to_sym do ; end
end

task :reset_cassette do
  require 'pry'
  puts ARGV
  exchange_name = ARGV.last
  if exchange_name.nil?
    puts "no exchange name given."
    next
  end

  exchange_name = exchange_name.capitalize

  cassette_types = ["pairs", "ticker", "order_book", "trade"]

  cassette_paths = cassette_types.map do |cassette_type|
    "spec/cassettes/vcr_cassettes/#{exchange_name}/integration_specs_fetch_#{cassette_type}.yml"
  end

  cassette_paths.each do |path|
    File.delete(path) if File.exist?(path)
    puts "#{path} deleted for #{exchange_name}"
  end
end
