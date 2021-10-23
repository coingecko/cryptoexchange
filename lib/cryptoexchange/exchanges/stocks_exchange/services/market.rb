module Cryptoexchange::Exchanges
  module StocksExchange
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::StocksExchange::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['market_name'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: pair['currency_code'],
                            target: pair['market_code'],
                            market: Cryptoexchange::Exchanges::StocksExchange::Market::NAME
                          )
            adapt(pair, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = StocksExchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['volumeQuote'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
