module Cryptoexchange::Exchanges
  module GoExchange
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
          "#{Cryptoexchange::Exchanges::GoExchange::Market::API_URL}/exchange/ticker"
        end

        def adapt_all(output)
          output["result"].map do |pair|
            base, target = GoExchange::Market.separate_symbol(pair["symbol"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: GoExchange::Market::NAME
                          )
            adapt(pair, market_pair)
          end.compact          
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = GoExchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume_24h']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
