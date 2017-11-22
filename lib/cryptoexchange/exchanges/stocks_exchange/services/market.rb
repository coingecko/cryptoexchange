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
          output.map do |pair|
            base, target = pair['market_name'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: StocksExchange::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = StocksExchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol']) / ticker.last
          ticker.timestamp = output['updated_time']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
