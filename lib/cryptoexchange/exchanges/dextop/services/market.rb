module Cryptoexchange::Exchanges
  module Dextop
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
          "#{Cryptoexchange::Exchanges::Dextop::Market::API_URL}/pairlist/ETH"
        end


        def adapt_all(output)
          output['pairs'].map do |ticker|
            target, base = ticker['pairId'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Dextop::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Dextop::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.change    = NumericHelper.to_d(output['change24'])
          ticker.high      = NumericHelper.to_d(output['high24'])
          ticker.low       = NumericHelper.to_d(output['low24'])
          ticker.volume    = NumericHelper.to_d(output['amount24'])
          ticker.timestamp = output['timeMs'].to_i/1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
