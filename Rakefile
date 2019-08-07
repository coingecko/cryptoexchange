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
