require 'spec_helper'

RSpec.describe Cryptoexchange::Services::Market do
  context 'fetch multiple tickers' do
    it 'calls the HTTP only once for subsequent calls when TTL cache is > 0' do
      market_service = Cryptoexchange::Services::Market.new
      allow(market_service).to receive(:http_get).and_return('[{"cur":"USD","symbol":"USD/RUR","last":60.50000000,"high":60.50000000,"low":53.50000000,"volume":4985.92377797,"vwap":57.34041416,"max_bid":60.50000000,"min_ask":5.38990000,"best_bid":59.31001000,"best_ask":60.45000000},{"cur":"EUR","symbol":"EUR/USD","last":1.14696000,"high":1.14696000,"low":1.09710000,"volume":327.00339925,"vwap":1.12049076,"max_bid":1.14696000,"min_ask":1.09710000,"best_bid":1.14696000,"best_ask":1.14999000},{"cur":"BTC","symbol":"BTC/USD","last":2580.01000000,"high":2619.97997000,"low":2559.87000000,"volume":1330.88261852,"vwap":2593.51329524,"max_bid":2620.00000000,"min_ask":2340.00000000,"best_bid":2580.00000000,"best_ask":2589.99999000},{"cur":"BTC","symbol":"BTC/EUR","last":2349.99725000,"high":2354.85724000,"low":2112.00001000,"volume":15.71664893,"vwap":2329.62859397,"max_bid":2354.85724000,"min_ask":2000.00000000,"best_bid":2118.00001000,"best_ask":2349.99725000}]')
      allow(LruTtlCache).to receive(:ticker_cache).and_return(LruRedux::TTL::Cache.new(100, 1))
      expect(market_service).to receive(:http_get).once
      market_service.fetch('api.something.com')
      market_service.fetch('api.something.com')
    end

    it 'calls the HTTP only twice for subsequent calls when TTL cache is 0' do
      market_service = Cryptoexchange::Services::Market.new
      allow(market_service).to receive(:http_get).and_return('[{"cur":"USD","symbol":"USD/RUR","last":60.50000000,"high":60.50000000,"low":53.50000000,"volume":4985.92377797,"vwap":57.34041416,"max_bid":60.50000000,"min_ask":5.38990000,"best_bid":59.31001000,"best_ask":60.45000000},{"cur":"EUR","symbol":"EUR/USD","last":1.14696000,"high":1.14696000,"low":1.09710000,"volume":327.00339925,"vwap":1.12049076,"max_bid":1.14696000,"min_ask":1.09710000,"best_bid":1.14696000,"best_ask":1.14999000},{"cur":"BTC","symbol":"BTC/USD","last":2580.01000000,"high":2619.97997000,"low":2559.87000000,"volume":1330.88261852,"vwap":2593.51329524,"max_bid":2620.00000000,"min_ask":2340.00000000,"best_bid":2580.00000000,"best_ask":2589.99999000},{"cur":"BTC","symbol":"BTC/EUR","last":2349.99725000,"high":2354.85724000,"low":2112.00001000,"volume":15.71664893,"vwap":2329.62859397,"max_bid":2354.85724000,"min_ask":2000.00000000,"best_bid":2118.00001000,"best_ask":2349.99725000}]')
      allow(LruTtlCache).to receive(:ticker_cache).and_return(LruRedux::TTL::Cache.new(100, 0))
      expect(market_service).to receive(:http_get).twice
      market_service.fetch('api.something.com')
      market_service.fetch('api.something.com')
    end
  end
end
