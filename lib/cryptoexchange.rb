require "cryptoexchange/version"
require "cryptoexchange/models/ticker"
require "cryptoexchange/models/market_pair"
require "cryptoexchange/services/market"
require "cryptoexchange/services/pairs"

%w(
  bitflyer
  coincheck
  coinone
  cryptopia
  gatecoin
).each do |market|
  require "cryptoexchange/exchanges/#{market}/market"
  require "cryptoexchange/exchanges/#{market}/models/ticker"
  require "cryptoexchange/exchanges/#{market}/models/market_pair"
  require "cryptoexchange/exchanges/#{market}/services/market"
  require "cryptoexchange/exchanges/#{market}/services/pairs"
end

require "http"

module Cryptoexchange
  # Your code goes here...
end
