module Cryptoexchange::Exchanges
  module Bitinka
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
          "#{Cryptoexchange::Exchanges::Bitinka::Market::API_URL}/ticker?format=json"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target =  pair[1]['volumen24hours'].keys
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitinka::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitinka::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]['last'].to_f)
          ticker.bid       = NumericHelper.to_d(output[1]['bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output[1]['ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output[1]['volumen24hours'][0].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
