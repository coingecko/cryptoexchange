module Cryptoexchange::Exchanges
  module Livecoin
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
          "#{Cryptoexchange::Exchanges::Livecoin::Market::API_URL}/exchange/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('/')
            market_pair = Cryptoexchange::Exchanges::Livecoin::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Livecoin::Market::NAME
                          )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Livecoin::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Livecoin::Market::NAME
          ticker.last      = output['last'] ? BigDecimal.new(output['last'].to_s) : nil
          ticker.bid       = output['best_bid'] ? BigDecimal.new(output['best_bid'].to_s) : nil
          ticker.ask       = output['best_ask'] ? BigDecimal.new(output['best_ask'].to_s) : nil
          ticker.high      = output['high'] ? BigDecimal.new(output['high'].to_s) : nil
          ticker.low       = output['low'] ? BigDecimal.new(output['low'].to_s) : nil
          ticker.volume    = output['volume'] ? BigDecimal.new(output['volume'].to_s) : nil
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
