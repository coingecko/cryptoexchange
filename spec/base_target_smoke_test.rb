require "bundler/setup"
require "cryptoexchange"

######################
# What is this script?
######################
# Use this script to test the Pairs of the market
# Results help you to determine if your base/target assignment is correct
# This smoke test is only as good as checking if major crypto like BTC, ETH
# do not appear as BASE when TARGET is an altcoin
# and
# appears as BASE when TARGET is generally a Fiat
#
################
# How to run?
################
#
# > ruby spec/base_target_smoke_test.rb
# > # Look at results to check for unusual assignments
#
#####

client = Cryptoexchange::Client.new

path_files = Dir[File.join(File.dirname(__dir__), 'lib', 'cryptoexchange', 'exchanges', '*')]
exchanges = path_files.map{ |file_name| file_name.downcase.split('/')[-1] }

national_fiats = ['USD', 'GBP', 'EUR', 'CHF', 'CNY', 'JPY', 'CAD', 'AUD', 'RUB', 'RUR', 'SEK', 'HKD', 'SGD', 'TWD', 'KRW', 'ZAR', 'INR', 'MYR', 'IDR', 'BRL', 'NZD', 'MXN', 'PHP', 'DKK', 'PLN', 'XAU', 'XAG', 'XDR']
crypto_fiats = ['USDT', 'NZDT']
fiats = national_fiats + crypto_fiats
fiats_with_btc = fiats + ['BTC', 'XBT']

####
# Optionally, for your checking purposes during development
# exchanges = [ '<exchange_name_you_are_working_on>' ]
#

exchanges.each do |exchange|
  pairs = client.pairs(exchange)
  puts "fetching... #{exchange}"

  # Flag for review if pair has base = BTC/XBT and target = NOT FIAT
  bad_pairs = pairs.select { |pair| (pair.base == 'BTC' || pair.base == 'XBT') && ( ! fiats.include? pair.target)}

  unless bad_pairs.empty?
    puts "***** #{exchange} *****"
    puts bad_pairs.inspect
  end

  # Flag for review if pair has base = ETH and target = NOT FIAT / NOT BTC or XBT
  bad_pairs = pairs.select { |pair| (pair.base == 'ETH') && ( ! fiats_with_btc.include? pair.target)}

  unless bad_pairs.empty?
    puts "***** #{exchange} *****"
    puts bad_pairs.inspect
  end
end



