module Cryptoexchange::Exchanges
  module Buyucoin
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
          "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/liveData"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            target, base = ticker['marketName'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Buyucoin::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Buyucoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.high      = NumericHelper.to_d(output['h24'])
          ticker.low       = NumericHelper.to_d(output['l24'])
          ticker.change    = NumericHelper.to_d(output['c24'])
          ticker.last      = NumericHelper.to_d(output['LTRate'])
          ticker.volume    = NumericHelper.to_d(output['v24'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
