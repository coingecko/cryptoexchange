module Cryptoexchange::Exchanges
  module Bitsonic
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["result"], market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitsonic::Market::API_URL}/external/ticker/24hr?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitsonic::Market::NAME
          ticker.last      = NumericHelper.to_d(output['x'])
          ticker.high      = NumericHelper.to_d(output['h'])
          ticker.low       = NumericHelper.to_d(output['l'])
          ticker.volume    = NumericHelper.to_d(output['q'])
          ticker.change    = NumericHelper.to_d(output['p'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
