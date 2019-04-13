module Cryptoexchange::Exchanges
  module Bitsten
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
          "#{Cryptoexchange::Exchanges::Bitsten::Market::API_URL}/public/getticker/all"
        end

        def adapt_all(output)
          output['result'].map do |pair, ticker|
            base, target = pair.split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitsten::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker         = Cryptoexchange::Models::Ticker.new
          ticker.base    = market_pair.base
          ticker.target  = market_pair.target
          ticker.market  = Bitsten::Market::NAME
          ticker.ask     = NumericHelper.to_d(output['ask'])
          ticker.bid     = NumericHelper.to_d(output['bid'])
          ticker.last    = NumericHelper.to_d(output['last'])
          ticker.high    = NumericHelper.to_d(output['high'])
          ticker.low     = NumericHelper.to_d(output['low'])
          ticker.change  = NumericHelper.to_d(output['change'])
          ticker.volume  = NumericHelper.divide(NumericHelper.to_d(output['basevolume']), ticker.last)
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
