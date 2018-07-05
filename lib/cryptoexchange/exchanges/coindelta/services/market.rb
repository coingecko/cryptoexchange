module Cryptoexchange::Exchanges
  module Coindelta
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
          "#{Cryptoexchange::Exchanges::Coindelta::Market::API_URL}/public/getticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['MarketName'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coindelta::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coindelta::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
