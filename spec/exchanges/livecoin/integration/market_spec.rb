require 'spec_helper'

RSpec.describe 'Livecoin integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Livecoin::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'livecoin'
  end

  context 'fetch ticker' do
    before(:all) do
      btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'livecoin')
      @ticker = Cryptoexchange::Exchanges::Livecoin::Services::Market.new.fetch(btc_usd_pair)
    end
    it { expect(@ticker.base).to_not be nil }
    it { expect(@ticker.target).to_not be nil }
    it { expect(@ticker.market).to eq 'livecoin' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to_not be nil }
    it { expect(@ticker.payload).to_not be nil }
  end

  context 'fetch multiple tickers' do
    before(:all) do
      @btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'livecoin')
      @btc_eur_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'EUR', market: 'livecoin')

      @market_service = Cryptoexchange::Exchanges::Livecoin::Services::Market.new
    end

    it 'calls the HTTP only once for subsequent calls' do
      double(Cryptoexchange::Exchanges::Livecoin::Services::Market)
      allow(@market_service).to receive(:http_get).and_return('[{"cur":"USD","symbol":"USD/RUR","last":60.50000000,"high":60.50000000,"low":53.50000000,"volume":4985.92377797,"vwap":57.34041416,"max_bid":60.50000000,"min_ask":5.38990000,"best_bid":59.31001000,"best_ask":60.45000000},{"cur":"EUR","symbol":"EUR/USD","last":1.14696000,"high":1.14696000,"low":1.09710000,"volume":327.00339925,"vwap":1.12049076,"max_bid":1.14696000,"min_ask":1.09710000,"best_bid":1.14696000,"best_ask":1.14999000},{"cur":"BTC","symbol":"BTC/USD","last":2580.01000000,"high":2619.97997000,"low":2559.87000000,"volume":1330.88261852,"vwap":2593.51329524,"max_bid":2620.00000000,"min_ask":2340.00000000,"best_bid":2580.00000000,"best_ask":2589.99999000},{"cur":"BTC","symbol":"BTC/EUR","last":2349.99725000,"high":2354.85724000,"low":2112.00001000,"volume":15.71664893,"vwap":2329.62859397,"max_bid":2354.85724000,"min_ask":2000.00000000,"best_bid":2118.00001000,"best_ask":2349.99725000}]')
      expect(@market_service).to receive(:http_get).once
      @market_service.fetch @btc_usd_pair
      @market_service.fetch @btc_eur_pair
    end
  end
end
