module Cryptoexchange::Exchanges
  module Utorg
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
          "#{Cryptoexchange::Exchanges::Utorg::Market::API_URL}/market/stats"
        end

        def adapt_all(output)
          pairs_map = {}
          pairs = Cryptoexchange::Exchanges::Utorg::Services::Pairs.new.fetch
          pairs.each do |m|
            pairs_map["#{m.base}-#{m.target}"] = m
          end

          output.map do |ticker|
            pair = pairs_map[ticker["title"]]
            next if pair.nil?
            adapt(ticker, pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Utorg::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['ohlcv']['high'])
          ticker.low       = NumericHelper.to_d(output['ohlcv']['low'])
          ticker.volume    = NumericHelper.to_d(output['ohlcv']['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
