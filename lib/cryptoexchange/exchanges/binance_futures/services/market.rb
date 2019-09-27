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

        def ticker_url
          "#{Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL}/ticker/24hr"
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
            adapt(ticker, pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BinanceFutures::Market::NAME
          ticker.inst_id   = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
