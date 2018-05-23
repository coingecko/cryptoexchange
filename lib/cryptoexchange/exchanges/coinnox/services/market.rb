module Cryptoexchange::Exchanges
  module Coinnox
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
          "#{Cryptoexchange::Exchanges::Coinnox::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |key, value|
            separator = /(USDT|BTC|BCH|ETH)\z/i =~ key
            base      = key[0..separator - 1]
            target    = key[separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinnox::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinnox::Market::NAME
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'sell'))
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'buy'))
          ticker.last      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'last'))
          ticker.high      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'high'))
          ticker.low       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'low'))
          ticker.volume    = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'vol'))
          ticker.timestamp = NumericHelper.to_d(output['at'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
