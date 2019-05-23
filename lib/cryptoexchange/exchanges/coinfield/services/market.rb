module Cryptoexchange::Exchanges
  module Coinfield
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
          "#{Cryptoexchange::Exchanges::Coinfield::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['markets'].map do |ticker|
            market_pair = split_symbol(ticker['market'])
            next if market_pair.nil?
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair[:base]
          ticker.target    = market_pair[:target]
          ticker.market    = Coinfield::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end

        private

        def split_symbol(pair)
          separator = /(XRP|USDC|USD|CAD|EUR|GBP|JPY|AED)\z/i =~ pair
          return nil if separator.nil?

          {
            base:   pair[0..(separator -1)],
            target: pair[separator..-1]
          }
        end
      end
    end
  end
end
