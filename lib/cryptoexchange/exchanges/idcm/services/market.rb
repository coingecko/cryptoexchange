module Cryptoexchange::Exchanges
  module Idcm
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
          "#{Cryptoexchange::Exchanges::Idcm::Market::API_URL}/RealTimeQuote/GetRealTimeQuotes"
        end

        def adapt_all(output)
          output['Data'].map do |market|
            base, target = market['TradePairCode'].split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Idcm::Market::NAME
            )
            adapt(market, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Idcm::Market::NAME
          ticker.last      = NumericHelper.to_d(output['LastPrice'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.change    = NumericHelper.to_d(output['Change'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
