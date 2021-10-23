module Cryptoexchange::Exchanges
  module Newdex
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
          "#{Cryptoexchange::Exchanges::Newdex::Market::API_URL}/v1/ticker/all"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            inst_id, base, target = ticker["symbol"].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: inst_id,
              market: Newdex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker                = Cryptoexchange::Models::Ticker.new
          ticker.base           = market_pair.base
          ticker.target         = market_pair.target
          ticker.inst_id        = market_pair.inst_id
          ticker.market         = Newdex::Market::NAME
          ticker.last           = NumericHelper.to_d(output['last'])
          ticker.high           = NumericHelper.to_d(output['high'])
          ticker.low            = NumericHelper.to_d(output['low'])
          ticker.change         = NumericHelper.to_d(output['change'])
          ticker.volume         = NumericHelper.to_d(output['amount'])
          ticker.timestamp      = nil
          ticker.payload        = output
          ticker
        end
      end
    end
  end
end
