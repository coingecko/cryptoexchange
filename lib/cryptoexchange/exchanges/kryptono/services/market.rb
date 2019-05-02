module Cryptoexchange::Exchanges
  module Kryptono
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
          "#{Cryptoexchange::Exchanges::Kryptono::Market::MARKET_API_URL}"
        end


        def adapt_all(output)
          timestamp = output['t'] / 1000
          output['result'].map do |ticker|
            base, target = ticker['MarketName'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Kryptono::Market::NAME
            )
            adapt(ticker, market_pair, timestamp)
          end
        end

        def adapt(output, market_pair, timestamp)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kryptono::Market::NAME
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
