module Cryptoexchange::Exchanges
  module BinanceFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def adapt_all(output)
          pairs_map = {}
          pairs = Cryptoexchange::Exchanges::BinanceFutures::Services::Pairs.new.fetch
          pairs.each do |m|
            pairs_map["#{m.inst_id}"] = m
          end

          output.map do |ticker|
            pair = pairs_map[ticker["symbol"]]
            next if pair.nil?

            funding = fetch_using_get(funding_url(ticker["symbol"]))
            index = fetch_using_get(index_url(ticker["symbol"]))

            adapt(ticker, funding, index, pair)
          end.compact
        end

        def adapt(ticker_market, funding, index, market_pair)
          ticker           = Cryptoexchange::Models::TickerDerivative.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BinanceFutures::Market::NAME
          ticker.inst_id   = market_pair.inst_id
          ticker.last      = NumericHelper.to_d(ticker_market['lastPrice'])
          ticker.high      = NumericHelper.to_d(ticker_market['highPrice'])
          ticker.low       = NumericHelper.to_d(ticker_market['lowPrice'])
          ticker.volume    = NumericHelper.to_d(ticker_market['volume'])

          # Derivatives
          ticker.start_timestamp = nil
          ticker.expire_timestamp = nil
          # ticker.open_interest
          ticker.index     = index['markPrice'].to_f
          ticker.funding_rate = funding['lastFundingRate'].to_f * 100
          ticker.funding_rate_timestamp = funding['nextFundingTime']
          # ticker.next_funding_rate_predicted

          ticker.timestamp = nil
          ticker.payload = {
            ticker_market: ticker_market,
            funding: funding,
            index: index
          }
          ticker
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/ticker/24hr"
        end

        def expiration_url
        end

        def open_interest_url
        end

        def funding_url(inst_id)
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/premiumIndex?symbol=#{inst_id}"
        end

        def index_url(inst_id)
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/premiumIndex?symbol=#{inst_id}"
        end
      end
    end
  end
end
