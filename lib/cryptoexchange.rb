require "cryptoexchange/version"
require "cryptoexchange/client"
require "cryptoexchange/models/ticker"
require "cryptoexchange/models/market_pair"
require "cryptoexchange/services/market"
require "cryptoexchange/services/pairs"

Cryptoexchange::Client::AVAILABLE_EXCHANGES.each do |market|
  require "cryptoexchange/exchanges/#{market}/market"
  require "cryptoexchange/exchanges/#{market}/models/ticker"
  require "cryptoexchange/exchanges/#{market}/models/market_pair"
  require "cryptoexchange/exchanges/#{market}/services/market"
  require "cryptoexchange/exchanges/#{market}/services/pairs"
end

require "http"
require "lru_redux"
