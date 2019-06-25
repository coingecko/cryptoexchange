module Cryptoexchange::Exchanges
  module MaxMaicoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::MaxMaicoin::Market::API_URL}/tickers/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = MaxMaicoin::Market::NAME

          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])        
          
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
