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
  require "cryptoexchange/exchange_template"

  identifier = ARGV.last
   
  if ARGV.count == 2
    template = Cryptoexchange::ExchangeTemplate.new(identifier)

    FileUtils.mkdir "lib/cryptoexchange/exchanges/#{identifier}/"
    FileUtils.mkdir "lib/cryptoexchange/exchanges/#{identifier}/services/"
    FileUtils.mkdir "spec/exchanges/#{identifier}/"
    FileUtils.mkdir "spec/exchanges/#{identifier}/integration/"

    File.open("lib/cryptoexchange/exchanges/#{identifier}/market.rb", "w+") { |file| file.write(template.market) }
    File.open("lib/cryptoexchange/exchanges/#{identifier}/services/pairs.rb", "w+") { |file| file.write(template.pairs) }
    File.open("lib/cryptoexchange/exchanges/#{identifier}/services/market.rb", "w+") { |file| file.write(template.tickers) }
    File.open("lib/cryptoexchange/exchanges/#{identifier}/services/order_book.rb", "w+") { |file| file.write(template.order_book) }
    File.open("lib/cryptoexchange/exchanges/#{identifier}/services/trades.rb", "w+") { |file| file.write(template.trades) }

    File.open("spec/exchanges/#{identifier}/market_spec.rb", "w+") { |file| file.write(template.market_spec) }
    File.open("spec/exchanges/#{identifier}/integration/market_spec.rb", "w+") { |file| file.write(template.integration_spec) }

    task puts "#{identifier} create successfully"
  else
    task puts "Please insert correct exchange name"
  end

  task identifier.to_sym do ; end
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
