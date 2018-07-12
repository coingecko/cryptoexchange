module Cryptoexchange::Exchanges
  module Coindcx
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
          "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL}/exchange/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            pair = ticker['market'].insert(-4, '/')
            target, base = pair.split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                           base: base,
                           target: target,
                           market: Coindcx::Market::NAME
                         )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coindcx::Market::NAME

          ticker.change    = NumericHelper.to_d(output['change_24_hour'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
